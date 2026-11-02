# Freestyle — Product Overview

## One-line pitch

**Freestyle is a stripped-back live-looping iPhone instrument: hold to record, release to loop, and build a song by playing with it.**

## Why it should exist

A lot of people have musical ideas before they have a session open. They can beatbox a groove, sing a hook, play a bass line, or tap out a rhythm—but traditional mobile music software often turns that impulse into setup work: choose a project, find a track type, configure a grid, manage a timeline, learn a mixer.

Freestyle should protect the impulse.

The experience is designed to feel closer to a physical loop pedal, an instrument, or a responsive game than a shrunken desktop DAW. It should reward experimentation, make early mistakes recoverable, and give users enough structure to stay in time without making them engineer a song before they can hear one.

## Product promise

When someone has a sound in their head, Freestyle helps them turn it into a living loop quickly enough that the original feeling survives.

That means:

- the central action is obvious on first contact;
- the system gives rhythmic support without demanding music-theory fluency;
- a user can make something satisfying in under a minute;
- a more experienced musician can perform, layer, and shape an arrangement without fighting the phone.

## Who it is for

Freestyle is aimed first at:

- people who casually make music with their voice, hands, guitar, keys, or whatever is nearby;
- songwriters who want to catch a sketch before opening a larger production tool;
- performers and producers looking for a playful, mobile loop surface;
- beginners who find conventional DAWs intimidating.

It is not initially trying to replace a full production environment, multitrack editor, sample library, or professional mastering suite.

## The core loop

### Create the shared musical frame

A new session begins with a small number of musical choices:

- loop length: **1–16 bars**;
- tempo;
- time signature;
- metronome and optional count-in.

The first release should prioritize the time signatures most people expect, then grow from validated use. A practical starting point is 4/4, with 3/4 and 6/8 as likely next candidates.

### Capture a layer

Each track has a large, direct primary action:

1. Select an empty track.
2. Press and hold to record.
3. Make a sound: beatbox, sing, play, clap, record an instrument, or capture a texture.
4. Release to end the capture.
5. The app resolves that take into the shared loop and begins playback.

Quantization and count-in should be helpful, not mysterious. The product needs clear rules for what happens when a user releases early or late, plus feedback that says what the app heard and where the loop will begin.

### Build and perform

A session supports up to **10 tracks**. Tracks can be freely named and colored; suggested starter roles make the blank canvas less intimidating:

| Suggested role | What it might hold |
| --- | --- |
| Drums | Beatboxing, taps, or programmed drums |
| Bass | Vocal bass, an instrument, or a synth line |
| Chords | Guitar, keys, pads, or stacked vocals |
| Melody | A lead phrase or hook |
| Vocal | Main vocal, harmonies, spoken word |
| Percussion | Claps, shakers, finger taps |
| Texture | Field recording, ambience, noise |
| FX | Risers, transitions, ear candy |

The user can mute, solo, or shape layers and use the session like an instrument. A sound does not need to belong to a preset role; the role system should offer momentum, not enforce a production template.

## Drum mode

Any suitable track can switch into **tap-to-play drum-machine mode**. Instead of recording from the microphone, the user plays pads or a compact performance surface to add kicks, snares, hats, and other sounds into the current musical frame.

The design intention:

- playability comes before step-sequencer density;
- taps are visually and rhythmically anchored to the same loop as audio tracks;
- quantization is easy to understand and easy to relax or disable later;
- an entry-level kit should get someone moving without forcing a sample-browser session.

A step editor may become useful, but it is not the opening move of the product.

## Sound shaping

Freestyle needs enough shaping to make a loop feel expressive without turning every track into a channel strip. Candidate tools include:

- level, mute, solo, and pan;
- a small selection of musical effects such as filter, delay, and reverb;
- simple tone, pitch, or harmonizer options where they prove useful;
- lightweight input monitoring and gain protection.

The first playable build should validate a narrow set of reliable controls. Effects, synths, harmonizers, and expanded kits are product opportunities—not promises for the first release.

## The interface philosophy: no timeline by default

Freestyle deliberately does not lead with a conventional horizontal arrangement timeline. A timeline is excellent for detailed editing; it is rarely the fastest way to start making noise.

The default experience should communicate:

- what is playing now;
- where the session is in the bar;
- which tracks are armed, recording, full, muted, or soloed;
- the energy and shape of the loop.

Editing and precision tools can exist behind a clear mode or later expansion, but they should not be the price of entry. The home surface should make the next musical action feel obvious.

## Flow — a future auto-mix/performance concept

**Flow** is a proposed opt-in performance helper, not an autonomous replacement for the musician.

At its most useful, Flow could read the current session and make restrained, musical moves: bring parts in and out, create a sense of dynamics, add a transitional effect, or help a loop feel like it has sections. The user should remain in control and be able to see, undo, or override any move.

Before committing to it, the team needs to learn:

- whether users want help arranging or only want fast looping;
- which moves reliably feel musical rather than random;
- how transparent the system needs to be during performance;
- how Flow can be valuable with minimal data collection and no surprise behavior.

A small “suggest an arrangement” prototype may be a better first test than a fully automated mode.

## AI Remix — a future expansion

The long-term idea is an **AI Remix** action that can use the user’s recorded layers as separate stems and propose alternative arrangements, grooves, or stylistic takes.

The important constraints are product constraints, not just model capability:

- it must be clearly opt-in;
- originals and stems must remain intact;
- results should be presented as versions, never destructive replacements;
- privacy, rights, processing time, and cost must be designed before release;
- no specific output quality, provider, or availability is promised here.

The first product has to earn the right to add AI by making the non-AI loop experience feel great.

## Free and paid positioning (proposed)

Freestyle should not put the core act of making music behind a paywall. The free version needs to be a real instrument: a user should be able to start a session, record and layer loops, use a useful basic kit and set of controls, and decide whether the product belongs in their life.

A paid tier or paid expansions could fund deeper creative value, such as:

- additional kits, sounds, and visual themes;
- expanded effects, instruments, and advanced sound-shaping tools;
- larger project/storage needs or export formats;
- Flow and AI Remix features where their operating cost justifies it.

Exact limits, subscription versus one-time purchase, and pricing are **not decided**. The guardrail is simple: monetize optional depth and ongoing-cost features, not the basic moment of “I had an idea and turned it into music.”

## First playable experience

The initial product should be judged by one question: can a person make a loop that feels good to play with?

A focused first milestone may include:

- iPhone session creation with tempo, bar length, and a metronome;
- low-latency audio capture and synchronized loop playback;
- a small set of tracks, moving toward the 10-track target;
- clear hold-to-record / release-to-loop behavior;
- basic mute, level, undo/delete, and session save;
- one simple drum-play mode;
- geometric playback feedback that is helpful, not cosmetic.

Deliberately defer until the core feels solid:

- elaborate editing;
- a broad sound marketplace;
- full arrangement editing;
- sophisticated auto-mix;
- AI remix;
- social features;
- a dense mixer.

## Technical direction

Freestyle is proposed as a hybrid iOS architecture.

### React Native + Expo: product shell and UI velocity

React Native with Expo is a strong fit for the parts of the app that benefit from fast iteration:

- onboarding, permissions, settings, and navigation;
- session library, exports, and account/product surfaces;
- most screens, controls, and visual UI;
- product state that is not sample-accurate.

### Native Swift + AVAudioEngine: the musical engine

Native Swift should own audio-critical work using AVAudioEngine and the iOS audio session:

- microphone capture and input monitoring;
- sample-accurate loop scheduling and synchronized playback;
- audio-session configuration, route/interruption handling, and latency measurement;
- real-time level metering and candidate effects;
- persistence/export of audio assets and session timing data.

JavaScript should not be in the timing path for recording, playback, quantization, or scheduling.

### Bridge contract

The bridge should be intentionally small and declarative. The UI asks the engine to do things such as create a session, arm a track, begin/end recording, change transport state, or apply a parameter. The engine returns state/events such as transport position, track state, meters, errors, and completed takes.

This boundary keeps the product interface flexible while preserving the reliability that makes an audio instrument feel trustworthy.

### Technical proof points

Before expanding features, validate on real target devices:

1. end-to-end record/release/playback latency;
2. loop alignment over repeated cycles;
3. stability with multiple active tracks;
4. behavior under Bluetooth, wired headphones, speaker, interruptions, and route changes;
5. CPU, memory, and battery use;
6. clear recovery when microphone permission or audio routing fails.

## Success signals

Early success is not a feature checklist. We should look for signs that the core interaction creates momentum:

- a new user records a first satisfying loop without help;
- users build multiple layers in one session;
- users return to reopen or add to a loop;
- users can explain what the app does in one sentence;
- testers ask for deeper tools because the basic loop interaction already works.

## Open decisions

- How much quantization should be automatic versus user-controlled?
- What should happen when the first recording does not cleanly fit the chosen loop length?
- Does 10 tracks feel creatively generous while still performant on target devices?
- Which time signatures belong at launch?
- Which visual language best supports timing in bright daylight and in a dark room?
- What is the cleanest recovery path after a bad take?
- What should be local-only, and what would justify cloud/account infrastructure?

## Working principle

**Make the first sound easy. Make the next layer irresistible. Keep the technology invisible until the user asks for it.**