# Freestyle

> A live-looping iPhone instrument that feels more like a game you can play than a miniature DAW.

Freestyle is a music-making app for catching an idea the second it appears. Hold a track to record a voice, beat, instrument, or found sound; release it to loop; then build the next layer. The interface stays out of the way so the user can stay inside the moment.

**Record → loop → layer → play.**

This repository is the home for the product direction and the work required to turn that feeling into a real, low-latency iPhone experience.

## The idea

Live looping is powerful, but most tools make a beginner think about tracks, timelines, routing, and settings before they have made a sound. Freestyle takes the opposite approach:

- **One tactile gesture:** hold to capture, release to loop.
- **A playable canvas:** up to 10 layers can build a complete little world.
- **Drums without a setup screen:** switch a track to tap-to-play drum-machine mode.
- **Rhythm you can see:** geometric visuals make the beat and the arrangement feel alive.
- **Creative momentum over administration:** no traditional timeline in the default experience.

The goal is not to reproduce a desktop DAW on a phone. It is to make making something musical feel immediate, forgiving, and addictive.

## A session in a few seconds

1. Pick a loop length (1–16 bars), tempo, and time signature.
2. Tap a track, then **hold** it to record. A metronome/count-in can keep the first pass grounded.
3. **Release** the track. Freestyle closes or quantizes the take to the loop and immediately plays it back.
4. Add another layer: bass, chords, a melody, a vocal, texture, percussion—whatever the song asks for.
5. Switch a track into **drum mode** to tap beats into the same shared loop.
6. Mute, solo, shape, and perform the arrangement while its visual field responds to the rhythm.

Starter roles may include Drums, Bass, Chords, Melody, Vocal, Texture, Percussion, and FX, but roles are invitations—not constraints. Any track can be whatever the user needs.

## Product direction

- [Product overview](docs/PRODUCT.md) — who Freestyle is for, its core loop, scope, Flow/AI Remix direction, positioning, and technical plan.
- [Design & UX](docs/DESIGN.md) — interaction rules, screen anatomy, visual language, feedback, accessibility, and open design questions.

## Technical direction

Freestyle is proposed as a hybrid iOS build:

- **React Native + Expo** for the product shell: onboarding, navigation, screens, account/export flows, and most interface state.
- **Native Swift + AVAudioEngine** for audio-critical work: recording, playback, scheduling, loop synchronization, audio-session control, and real-time effects.
- A deliberately small native bridge keeps timing-sensitive scheduling out of JavaScript while the UI stays fast to iterate on.

This is a direction, not an implementation claim. The first technical milestone is to prove reliable, musical capture-and-loop behavior on real devices before expanding the feature set.

## Product status

Freestyle is in concept and early product-definition work. The documents in this repo are living guides for collaborators; they distinguish the essential first playable experience from ideas that need validation.

## Contributing to the conversation

The most valuable questions right now are:

- Does the hold-to-record / release-to-loop gesture feel natural at real performance tempo?
- What is the smallest set of controls that lets someone make a loop they are proud of?
- Which visual behaviors help timing and confidence instead of becoming decoration?
- Which creative tools genuinely belong in the first version, and which should wait?

If you are exploring the project with us, start with [PRODUCT.md](docs/PRODUCT.md), then [DESIGN.md](docs/DESIGN.md).