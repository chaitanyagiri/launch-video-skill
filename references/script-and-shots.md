# Script and shot list

The writer model writes (Fable 5.2 or GPT 6.2 Astra, see `budget-and-models.md`). Give it:
BRIEF.md, the voice note transcript, SYNTHESIS.md, the feature list with real flows,
the asset inventory, and `lessons.md`.

## 1. Beat sheet first

A table in `launch/SCRIPT.md`: time in, time out, beat name, what is on screen, on screen
words, voice line (if any), sound. Rules:
- The hook is product or problem on screen by second 2. No logo intro.
- One idea per beat. Titles short enough for one line at a big size (aim for 2 to 6 words).
- Each feature beat names the feature and shows it working in the same 2 to 3 s.
- Use the user's own phrases from the voice note where they work.
- The end card: logo, one line, the URL; held at least 2 s.
- Spell out what is real and what is designed: every product shot cites its capture.

On Standard offer 2 script options, on Max 3, each with a one line angle. The user picks
or mixes. Then lock the words: later changes go through ITERATE.

## 2. Shot list

`launch/shots.json` (template in `templates/shots.json`). One entry per shot, plain
English, so the user can direct shot by shot. Fields:

- `id`, `start`, `end` (seconds)
- `screen`: which real screen or designed card
- `what_happens`: the action, step by step
- `camera`: static, push in, pull back, pan, 3D tilt, whip to next
- `zoom_and_focus`: what fills the frame and at what zoom
- `cursor`: none, or the path and clicks (a big drawn cursor reads best)
- `pop_out`: a component that lifts out of the window to centre over a blurred app
- `text_on_screen`: exact words, size, position
- `voice`: exact words or none
- `sfx`: cue names (click, whoosh, impact, type)
- `transition_out`: cut, whip, flood, zoom through, crossfade
- `assets`: file paths used
- `source`: for any claim or number, its source

Show the shot list as a readable table, not raw JSON. Ask: "Approve, or tell me which
shot to change." Many users want to direct shot by shot; welcome it and rebuild from
their version, not yours.

## 3. Voice (if any)

- The user's own recording: ask for a quiet room, phone or USB mic, one take per line,
  clap at the start if recorded with video.
- A stock synthetic voice: offer 3 to 4 auditions of the first two lines, let the user
  pick. Settings that worked for us with ElevenLabs: multilingual v2, stability about 0.4,
  style about 0.4, speed 1.1 to 1.2; numbers spelled out in the text.
- Tighten gaps between words in the edit, then check the result with a transcript.
- Never clone a real person's voice without their written consent.
