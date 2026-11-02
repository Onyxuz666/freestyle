# Freestyle — Design & UX Direction

## Design intent

Freestyle should feel like a responsive musical object on a phone—not a control room squeezed into a small rectangle.

The interface has two jobs:

1. make it immediately clear what the user can play, record, or change next;
2. make time visible enough that people feel confident performing without staring at a grid.

Everything else is secondary.

## Experience principles

### 1. One obvious next action

At any moment, the user should be able to answer: “What happens if I touch this?” Empty tracks invite a recording. A held track records. A full track plays. A drum track invites taps.

Do not make users open a menu to do the central thing.

### 2. The hand should learn the instrument

The primary gesture is physical and memorable:

- **press and hold** = capture sound;
- **release** = finish the capture and turn it into a loop.

Use persistent, immediate visual and haptic feedback so this becomes muscle memory. Keep alternate gestures rare and discoverable.

### 3. Rhythm is felt, seen, and heard

The user needs an intuitive sense of where the bar is without being forced to count tiny divisions. Motion, pulse, geometry, metronome cues, and track state should agree with one another.

Visual timing is assistive; sound remains the authority.

### 4. Powerful, not busy

Show the controls needed to make the next musical decision. Advanced shaping belongs in a focused layer or sheet, not permanently around every track.

### 5. Mistakes are cheap

A bad take should never feel like a dead end. Undo, replace, clear, mute, and re-record need to be fast, clear, and hard to trigger by accident.

### 6. Every response has a musical reason

Animation and visual effects should explain a beat, a recording state, an energy change, or a result. If an effect does not help a player understand or feel the session, it is decoration and should earn its place carefully.

## Default session surface

The default session surface is a performance view, not an arrangement editor.

~~~text
┌────────────────────────────────────────────┐
│  Session name            tempo · bars · ⓘ  │
│  4/4  ·  108 BPM  ·  4 bars       ◉ FLOW  │
│                                            │
│             reactive geometric field        │
│     (shows pulse, bar position, energy)    │
│                                            │
│  [ DRUMS  ●●●● ]   [ BASS    ◌◌◌◌ ]        │
│  [ CHORDS ●●●● ]   [ MELODY  ◌◌◌◌ ]        │
│  [ VOCAL  ◌◌◌◌ ]   [ TEXTURE ◌◌◌◌ ]        │
│                                            │
│  + add track                               │
│                                            │
│  [ transport / metronome / action feedback ]│
└────────────────────────────────────────────┘
~~~

This is an intent sketch, not a prescribed layout. The important hierarchy is:

1. shared musical context;
2. responsive visual pulse;
3. big, tappable tracks;
4. the primary performance/recording state;
5. deeper settings only when requested.

## Track anatomy and states

A track must communicate both its musical contribution and its immediate interaction state at a glance.

| State | User sees | User can do |
| --- | --- | --- |
| Empty | calm outlined cell / clear record affordance | hold to record, choose a starter role |
| Armed | a preparatory glow and clear countdown/quantization cue | cancel or begin capture |
| Recording | strong active color, elapsed/bar progress, input meter | continue holding; release to finish |
| Resolving | a brief, explicit “locking to loop” transition | wait; never leave uncertainty about what is happening |
| Playing | animated geometry aligned to the loop | mute, solo, shape, replace |
| Muted | visually subdued but still present | unmute |
| Soloed | focused/highlighted while other tracks recede | return to mix |
| Drum mode | pad/performance indicator and kit identity | tap to play, change kit/settings |
| Error/attention | concise message plus recovery action | retry, restore route/permission, dismiss |

Do not rely on color alone. State needs shape, labels or icons, motion, and accessibility-aware contrast.

## The recording interaction

### Entry

An empty audio track should look and feel pressable. A short instructional hint is useful only until the first successful recording; the interface should not keep explaining itself after the user has learned it.

### Hold

On touch-down, the user receives an immediate confirmation. If the product waits for a count-in or quantized boundary, show that waiting state distinctly from actual recording.

Once recording begins:

- the track visibly “opens” or fills;
- input level reacts without looking like a technical meter;
- the shared pulse shows the current bar position;
- the user can tell whether their release will end this bar, end immediately, or be quantized.

### Release

On release, provide a crisp confirmation that the take has become a loop. This could combine a tiny haptic, an audible confirmation designed not to distract, and a visual transition from capture to playback.

The first loop is the moment the product either feels magical or confusing. Design and engineering should test release timing relentlessly.

### Recovery

After the loop is created, make re-record, clear, undo, and mute easy to find. Avoid destructive long-press overload on the same surface as the core record gesture; accidental deletion is much worse than an extra tap.

## Drum-machine mode

Drum mode is an alternate way to contribute to the same session, not a separate product inside the app.

Guidelines:

- present a small, playable pad surface with high hit targets;
- keep kick/snare/hat roles obvious before exposing deep kit choices;
- show the current bar/pulse while pads are played;
- capture or quantize events into the shared loop in a way the user can understand;
- make it easy to return to the session surface without losing performance context.

A classic grid sequencer can be a later editing aid. The initial drum interaction should prioritize live tapping and instant feedback.

## Controls and progressive disclosure

### Always available

Keep the persistent control layer small:

- transport / global play state;
- metronome;
- tempo, bar length, and time signature entry points;
- add track;
- a lightweight undo/recovery action.

### Per-track, on demand

A tap or deliberate secondary action can reveal:

- volume;
- mute / solo;
- basic effects;
- rename/color;
- replace, clear, or duplicate when supported;
- drum-kit choices for drum tracks.

### Deep controls, later

Keep advanced editing, detailed automation, extensive effect chains, and library management out of the first-level session surface. They belong behind a purposeful transition—or outside the first release entirely.

## Geometric and reactive visual language

The visual world should behave like a living score. It may use circles, arcs, tiles, radial segments, grids, or other simple geometric forms, but it should obey a common system.

### What the visual language should communicate

- **Time:** a stable indicator of beat, bar, and loop cycle.
- **Layers:** distinct tracks retain an identity without becoming noisy.
- **Energy:** the composition can feel denser as layers are added.
- **Action:** record, release, mute, solo, and effects have readable visual consequences.
- **Playfulness:** the session looks worth touching.

### Motion rules

- Motion must be anchored to tempo. A 120 BPM session should not have decorative animation drifting independently of the beat.
- The downbeat deserves the clearest emphasis.
- Changes should favor short, legible transitions over continuous visual noise.
- When a track is muted, its visual energy recedes without suggesting it was deleted.
- High-energy visuals must respect Reduce Motion and preserve text/control legibility.

### Color and contrast

Use color as a track identity layer, not as the only state signal. The palette should work in low light and daylight, avoid visually punishing saturation across ten tracks, and maintain accessible contrast for labels and controls.

A useful starting approach is a dark instrument-like canvas with bright, limited track colors and a neutral global rhythm indicator. This is a direction to prototype, not a finalized brand palette.

## Flow visual behavior

If the future Flow concept is tested, it should feel like a transparent collaborator. Users should be able to see what Flow plans to do, why it happened, and how to stop or reverse it.

Design constraints:

- no hidden muting or destructive rearrangement;
- Flow activity should have an identifiable visual signature, distinct from user actions;
- the user remains the author—Flow proposes or performs within visible boundaries;
- an off switch and immediate manual override are non-negotiable.

## Feedback, sound, and haptics

Freestyle needs a compact feedback vocabulary:

| Moment | Feedback goal |
| --- | --- |
| Track becomes armed | “Your next action is ready.” |
| Count-in starts | “Recording is about to begin.” |
| Recording begins | “We are capturing now.” |
| Loop closes | “That take is now part of the song.” |
| Quantization changes a timing result | “The app helped in this specific, understandable way.” |
| Route/permission problem | “Here is what happened and how to recover.” |

Haptics and confirmation sounds should reinforce successful actions, never compete with the music. Offer settings to reduce or disable nonessential feedback.

## Accessibility and comfort

A music app cannot be “playful” only for users who can perceive every animation or hit a tiny target.

Design requirements from the beginning:

- large touch targets for tracks and pads;
- VoiceOver labels that explain state and the available action;
- text/icon/shape redundancy for all color-coded states;
- sufficient contrast and Dynamic Type support where text appears;
- Reduce Motion behavior that preserves timing information;
- haptics/sound toggles and clear microphone-permission recovery;
- a practical one-handed reach strategy for core controls.

## Empty, loading, and failure states

These states shape trust more than a mockup usually reveals.

- **First launch:** orient the user toward making a first sound, not account creation.
- **Empty session:** offer starter roles and a single clear action without implying there is a “right” way to start.
- **No microphone permission:** explain the benefit, then offer a clear path to enable it or use drum mode if appropriate.
- **Audio route change/interruption:** plainly say what changed and whether playback/recording has resumed, paused, or needs a user action.
- **Slow processing/resolution:** show a definite in-progress state; never make a take appear lost.
- **Deletion/replacement:** confirm consequences in proportion to risk and keep undo close.

## What not to do yet

To protect the central experience, avoid adding these by default in the early product:

- a permanent, dense mixer;
- a conventional timeline dominating the home screen;
- tiny, multi-layered icons with hidden long-press behavior;
- a giant sound browser before the core capture loop works;
- visual effects that obscure transport position;
- autonomous “AI” behavior without clear control, cost, and privacy rules.

## Prototype questions

The right design should be tested with real people and real sound. Early prototypes should answer:

1. Do people understand hold-to-record and release-to-loop without verbal instruction?
2. Can people predict when a loop will start and end?
3. Does the visual pulse improve timing confidence?
4. Is a 10-track surface readable and touchable on common iPhones?
5. Does drum mode feel like part of one instrument?
6. Which feedback feels satisfying, and which feels noisy or patronizing?
7. Do beginners want starter roles, a blank canvas, or both?
8. At what point do users ask for a timeline—and what problem are they actually trying to solve?

## North star

**The screen should make someone want to touch it, and every touch should make the music make more sense.**