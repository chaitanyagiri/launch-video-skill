# Build in HyperFrames

Load the HyperFrames skills before writing composition HTML (`/hyperframes`, then
`/hyperframes-core`, `/hyperframes-animation`, `/hyperframes-keyframes`, `/hyperframes-audio`
as needed). They own the composition contract; this file adds what we learned making
launch films with it.

## Project shape (`launch/film/`)

- `build.mjs` writes `index.html` from a scene list: `[scene id, authored length, played length]`.
  To retime a scene later, change only its played length; the scene's sub timeline is
  time scaled by authored / played, and cues follow.
- `style.css` holds the tokens: brand colours, fonts, sizes, the caption zone.
- `timeline.js` builds one GSAP sub timeline per scene and records SFX cue points
  (`cue(name, time)`) into the page so the mixer can read them.
- `mix.mjs` reads the cues (headless browser), lays SFX, voice and music into stems with
  ffmpeg, and muxes them onto the silent render.
- `assets/` captured screens, logos, icons, audio; `renders/` every version, never overwritten.
- `CHANGELOG.md` one line per version: what changed and why.

Render: `npx hyperframes render --fps 60 --quality delivery -o renders/<name>-silent.mp4 .`
then `node mix.mjs renders/<name>-silent.mp4 renders/<name>.mp4`. Run `npx hyperframes lint`
and `npx hyperframes check` before every render. Pin the HyperFrames version in package.json
and say when you bump it.

## Camera and layout patterns that worked

- Open on the full app window, then lift the component that matters to the centre over a
  blurred copy of the app: a rounded box with a soft shadow, no grey frame around it.
- Zoom by moving a camera layer holding the whole window (frames of `{cx, cy, scale}` per
  beat); keep the cursor in the same layer so it stays on its target.
- Whip pan between scenes: both scenes move the full frame width together, same duration
  and ease, no blur. A partial move or a blur reads as a ghost on the edge.
- Accent flood: grow a circle of the accent colour from the button the cursor clicks to fill
  the frame, then reveal the next shot from it.
- Titles: one line where possible, measured at runtime from offsetWidth (not scrollWidth,
  which entry rotations inflate); fit the size to the box.
- A designed card for something you cannot capture must look designed (brand type,
  stylised), never like a fake screenshot.

## Sound

- SFX from a licensed pack, cued from the timeline: clicks on clicks, soft whooshes on
  camera moves, one impact on the biggest reveal. Thin them out: no SFX under every title,
  keep at least 0.2 s between hits except clicks.
- Music: measure the tempo with `scripts/bpm.py` and cut on bars. Extend or shorten a bed
  by repeating or removing whole bars, cutting just before a downbeat with a 6 ms crossfade.
- Master with `scripts/master.sh` (two pass loudnorm to -14 LUFS, true peak -1 dBTP) unless the
  user wants a quieter mix for their own music. Deliver stems (voice, SFX, music) separately.

## Gotchas (each one cost us a round)

- GSAP `fromTo` applies its from state at time 0 (`immediateRender` is true). A flood or wipe
  element set up with fromTo sits visible from the start. Use `immediateRender: false`.
- Adding a child timeline at a negative position shifts the whole parent timeline. Start
  the first scene's clock at 0.
- Never tween x or y on the camera element for an entrance; it overwrites the camera's own
  position. Fade the camera with opacity and move an inner wrapper.
- A child set to `visibility: visible` shows through a hidden parent scene. Hide scene
  content with opacity, never visibility.
- A `<video>` with timing attributes must not sit inside another timed element (lint error).
  Drive the wrapper with GSAP opacity instead.
- Never name a class `cam` if the camera layer already uses that name.
- Two root files that both declare a composition id fail lint. Keep old versions outside the
  project root or renamed to `.txt`.
- A limiter with auto makeup gain raises the whole mix; set its level off.
- Heavy renders on a laptop: close other apps, render one film at a time, plug in the charger.

## Parallel build (Max tier)

Split scenes into groups by shared assets. Each builder gets: the shot entries for its
group, style.css tokens, the timeline helpers, the asset paths, and the gotchas list.
One integrator joins the groups, checks transitions between groups, and owns the render.
