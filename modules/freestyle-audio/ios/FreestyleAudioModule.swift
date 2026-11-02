import ExpoModulesCore
import AVFoundation

// All control calls run on main. Playback timing belongs to AVAudioEngine,
// never to the JavaScript polling timer used for the visual playhead.
public class FreestyleAudioModule: Module {
  private let looper = VoiceLooper()
  private func onMain<T>(_ work: () throws -> T) rethrows -> T {
    if Thread.isMainThread { return try work() }
    return try DispatchQueue.main.sync(execute: work)
  }
  public func definition() -> ModuleDefinition {
    Name("FreestyleAudio")
    AsyncFunction("prepare") { (promise: Promise) in
      AVAudioSession.sharedInstance().requestRecordPermission { granted in
        DispatchQueue.main.async {
          guard granted else { promise.reject("MIC_DENIED", "Enable microphone access in iPhone Settings."); return }
          do { try self.looper.prepare(); promise.resolve(nil) }
          catch { promise.reject("AUDIO_SETUP", error.localizedDescription) }
        }
      }
    }.runOnQueue(.main)
    Function("play") { (bpm: Double) in try self.onMain { try self.looper.play(bpm) } }
    Function("stop") { self.onMain { self.looper.stop() } }
    Function("beginRecording") { (track: Int) in try self.onMain { try self.looper.begin(track) } }
    Function("endRecording") { try self.onMain { try self.looper.finish() } }
    Function("mute") { (track: Int) in try self.onMain { try self.looper.mute(track) } }
    Function("clear") { (track: Int) in try self.onMain { try self.looper.clear(track) } }
    Function("getState") { try self.onMain { try self.looper.state() } }
    OnDestroy { DispatchQueue.main.async { self.looper.stop() } }
  }
}

private final class VoiceLooper {
  private let engine = AVAudioEngine()
  private let format = AVAudioFormat(standardFormatWithSampleRate: 48000, channels: 1)!
  private var players: [AVAudioPlayerNode] = []
  private var loops: [AVAudioPCMBuffer?] = Array(repeating: nil, count: 4)
  private var muted = Array(repeating: false, count: 4)
  private var recorder: AVAudioRecorder?
  private var takeURL: URL?
  private var recording = -1
  private var offset = 0
  private var origin: UInt64 = 0
  private var bpm = 100.0
  private var playing = false
  private var prepared = false
  private var observers: [NSObjectProtocol] = []
  private var seconds: Double { 480 / bpm } // Two bars of 4/4.
  private var frames: AVAudioFrameCount { AVAudioFrameCount((seconds * 48000).rounded()) }
  private func fail(_ message: String) -> NSError { NSError(domain: "FreestyleAudio", code: 1, userInfo: [NSLocalizedDescriptionKey: message]) }
  private func validate(_ track: Int) throws { if !(0..<4).contains(track) { throw fail("Invalid track.") } }

  func prepare() throws {
    let session = AVAudioSession.sharedInstance()
    try session.setCategory(.playAndRecord, mode: .measurement, options: [.defaultToSpeaker])
    try session.setPreferredSampleRate(48000)
    try session.setPreferredIOBufferDuration(0.005)
    try session.setActive(true)
    if !prepared {
      for _ in 0..<4 {
        let player = AVAudioPlayerNode()
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: format)
        players.append(player)
      }
      for name in [AVAudioSession.interruptionNotification, AVAudioSession.routeChangeNotification, AVAudioSession.mediaServicesWereResetNotification] {
        observers.append(NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in self?.stop() })
      }
      prepared = true
    }
  }

  func play(_ tempo: Double) throws {
    guard prepared else { throw fail("Enable the microphone first.") }
    guard tempo.isFinite && (60...180).contains(tempo) else { throw fail("Tempo must be 60–180 BPM.") }
    guard !playing else { return }
    if loops.contains(where: { $0 != nil }) && tempo != bpm { throw fail("Clear tracks before changing tempo.") }
    bpm = tempo
    try AVAudioSession.sharedInstance().setActive(true)
    engine.prepare()
    try engine.start()
    origin = mach_absolute_time() + AVAudioTime.hostTime(forSeconds: 0.1)
    playing = true
    for i in 0..<4 { if let buffer = loops[i] { schedule(i, buffer, origin) } }
  }

  private func schedule(_ track: Int, _ buffer: AVAudioPCMBuffer, _ host: UInt64) {
    let player = players[track]
    player.stop()
    player.volume = muted[track] ? 0 : 1
    player.scheduleBuffer(buffer, at: nil, options: .loops)
    player.play(at: AVAudioTime(hostTime: host))
  }

  private var elapsed: Double {
    let now = mach_absolute_time()
    return now > origin ? AVAudioTime.seconds(forHostTime: now - origin) : 0
  }

  func begin(_ track: Int) throws {
    try validate(track)
    guard playing && recording == -1 && loops[track] == nil else { throw fail("Record one empty track at a time.") }
    // Keep capture in a temporary PCM file; no disk writes occur in a render callback.
    let url = FileManager.default.temporaryDirectory.appendingPathComponent("freestyle-\(UUID().uuidString).caf")
    let take = try AVAudioRecorder(url: url, settings: [
      AVFormatIDKey: kAudioFormatLinearPCM, AVSampleRateKey: 48000,
      AVNumberOfChannelsKey: 1, AVLinearPCMBitDepthKey: 32,
      AVLinearPCMIsFloatKey: true, AVLinearPCMIsBigEndianKey: false
    ])
    take.prepareToRecord()
    // Wait for the shared start if the user records before the initial 100ms preroll.
    let now = mach_absolute_time()
    let delay = now < origin ? AVAudioTime.seconds(forHostTime: origin - now) : 0
    offset = Int((elapsed.truncatingRemainder(dividingBy: seconds)) * 48000) % Int(frames)
    guard take.record(atTime: take.deviceCurrentTime + delay, forDuration: seconds) else { throw fail("Microphone recording could not start.") }
    takeURL = url
    recorder = take
    recording = track
  }

  func finish() throws {
    guard recording >= 0, let take = recorder, let url = takeURL else { return }
    let track = recording
    take.stop()
    recording = -1
    recorder = nil
    takeURL = nil
    defer { try? FileManager.default.removeItem(at: url) }
    let file = try AVAudioFile(forReading: url)
    let count = AVAudioFrameCount(min(file.length, AVAudioFramePosition(frames)))
    guard count > 0 else { return }
    guard let captured = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: count),
          let loop = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frames) else { throw fail("Unable to allocate audio buffer.") }
    try file.read(into: captured, frameCount: count)
    loop.frameLength = frames
    guard let output = loop.floatChannelData?[0], let input = captured.floatChannelData?[0] else { throw fail("Unsupported recording format.") }
    for i in 0..<Int(frames) { output[i] = 0 }
    let length = Int(captured.frameLength)
    // A short fade reduces clicks at the two edges of each recorded take.
    for i in 0..<length {
      let fade = min(1, Float(min(i, length - 1 - i)) / 128)
      output[(offset + i) % Int(frames)] = input[i] * fade
    }
    loops[track] = loop
    if playing {
      let cycle = floor((elapsed + 0.05) / seconds) + 1
      schedule(track, loop, origin + AVAudioTime.hostTime(forSeconds: cycle * seconds))
    }
  }

  func stop() {
    // A stop cancels the in-progress take but preserves completed loops.
    recorder?.stop()
    recorder = nil
    if let url = takeURL { try? FileManager.default.removeItem(at: url) }
    takeURL = nil
    recording = -1
    players.forEach { $0.stop() }
    engine.stop()
    playing = false
  }
  func mute(_ track: Int) throws {
    try validate(track)
    muted[track].toggle()
    players[track].volume = muted[track] ? 0 : 1
  }
  func clear(_ track: Int) throws {
    try validate(track)
    guard recording == -1 else { throw fail("Finish recording before clearing a track.") }
    players[track].stop()
    loops[track] = nil
    muted[track] = false
  }
  func state() throws -> [String: Any] {
    if let take = recorder, !take.isRecording, elapsed > 0.2 { try finish() }
    return ["playing": playing, "recording": recording, "phase": playing ? elapsed.truncatingRemainder(dividingBy: seconds) / seconds : 0, "filled": loops.map { $0 != nil }, "muted": muted]
  }
  deinit { observers.forEach { NotificationCenter.default.removeObserver($0) } }
}
