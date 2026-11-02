# Freestyle

A pocket voice-looping instrument for iPhone. Hold a pad, make a sound, release it, and layer another track.

## First prototype

- Four voice tracks: Beat, Bass, Melody, Voice.
- Two bars in 4/4, 60–180 BPM. Tempo locks once a loop is recorded.
- Hold to record up to two bars; shorter takes are padded with silence.
- Playback starts on the next loop boundary, preserving the take's position within the phrase.
- Play/stop, mute, and clear. Stop cancels an unfinished take; completed loops survive stop/start.
- Visual beat indicator. No audible metronome yet.

The screen works in a browser as an explicitly labeled **interface preview**. Recording requires a custom iOS development build; Expo Go does not contain this app's native module.

## Develop

```sh
npm ci
npm run typecheck
npm run web
```

The project uses Expo SDK 58, React Native and TypeScript, with a local Expo module under `modules/freestyle-audio`. The native module is discovered automatically during the iOS build.

## First iPhone build

From Windows, use EAS Build with your Expo account and Apple signing credentials. These account and device setup steps have not been completed for this project:

```sh
npx eas-cli@latest login
npx eas-cli@latest build:configure
npx eas-cli@latest device:create
npx eas-cli@latest build --platform ios --profile development
```

Review the proposed bundle identifier `com.onyxuz666.freestyle` before registering it. Install the resulting development build on the registered iPhone, then run `npm start` and open the development server in that build. Keep the phone and PC on the same network, or use `npx expo start --dev-client --tunnel` if needed.

On a Mac with Xcode, `npm run ios -- --device` generates and builds the native project. Rebuild after changing Swift code.

## Audio implementation and limitations

AVAudioEngine schedules the four player nodes against one host-time origin. JavaScript polls state for display only. AVAudioRecorder captures temporary mono PCM files. The completed take is placed in a fixed-length loop buffer at its phrase offset, with short edge fades. Temporary recordings are removed after conversion or cancellation.

This is an **uncompiled, unvalidated native prototype** until an iOS build and physical-device checks pass. Recorder startup/input latency has not been calibrated; exact capture alignment is not guaranteed. Buffer creation currently occurs on the main thread and should move off it before production. Media-services resets may require restarting the app. No background playback, overdubbing, session persistence, export, effects, AI remix, or Android audio implementation is included.

Use wired headphones for initial testing. Speaker output can be picked up by the microphone. Sessions currently live only in memory.

## Device acceptance checks

1. Grant and deny microphone permission; denial must show a useful error.
2. Hold Beat, record a rhythm, and release. Hear it enter at the next two-bar boundary.
3. Record Bass during playback, including a take crossing a boundary. Listen for alignment and drift over five minutes.
4. Hold beyond two bars; verify automatic completion and no stuck recording state.
5. Check very short taps, stop during recording, clear, mute/unmute, and stop/restart.
6. Change headphone route, receive an interruption, and background the app. Transport should stop safely.
7. Run four full tracks for ten minutes; watch for clipping, dropouts, memory growth, and heat.

## Verification

Windows checks: TypeScript, web export, iOS JavaScript export, and native module autolinking. These do not compile Swift or validate audio on a device. The dependency audit currently reports 11 moderate advisories in Expo's transitive development tooling (`glob` / `minimatch`); review upstream updates before release rather than applying the suggested incompatible SDK downgrade.

No license has been granted. The podspec's `UNLICENSED` field is package metadata, not a license file.
