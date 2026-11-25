# Research: download and analyse the examples

Output folder: `launch/research/`. One folder per example: `refs/<nn>-<slug>/` with
`video.mp4`, `meta.json`, `frames/`, `sheet.jpg`, `transcript.txt`, and `analysis.md`.

## 1. Download

- Links: `scripts/fetch-refs.sh launch/research/refs <url> [<url> ...]` (yt-dlp; writes
  video.mp4 and meta.json with title, uploader, date, duration, views and likes where the
  site exposes them).
- If yt-dlp cannot reach a site (X, Instagram and TikTok change often), use the
  `agent-reach` skill if installed (`agent-reach doctor --json` shows which backend serves
  each platform), then save the file into the same folder shape.
- Files the user gave: copy them in as `video.mp4` and write a small meta.json by hand.
- Never sign in to a site with the user's password to download, never use cookies from
  their browser without asking, and never bypass a paywall.

## 2. Measure

`scripts/frames.sh <ref folder> [seconds between frames, default 1]` writes `frames/`,
a contact sheet `sheet.jpg`, `facts.json` (duration, resolution, fps, scene cuts from
ffmpeg scene detection, loudness), and `transcript.txt` if `scripts/transcribe.sh` can run.

Numbers in any analysis come only from the video itself, `facts.json` or `meta.json`.
If a number is not there, write "not in source".

## 3. Analyse each example (one helper per example on Standard and Max)

Brief for each helper, word for word plus the paths:

> Watch `video.mp4` as video if you can (motion and audio), else use `frames/`, `sheet.jpg`,
> `facts.json` and `transcript.txt`. Write `analysis.md` in the same folder. Open with
> product, account, post URL, date, duration, resolution, fps, views, likes (from meta.json).
> Then ten numbered sections:
> 1. Beat sheet: time in, time out, what is on screen, on screen text word for word, voice
>    line word for word (or "no voice").
> 2. Hook: the first 2 seconds and why it could stop a scroll.
> 3. Pacing: length, number of shots, median shot length, events per second.
> 4. Camera on UI: zooms, pans, 3D tilts, push ins, framing, how the real product is shown
>    (full window, crop, mock), cursor use.
> 5. Motion graphics: type style and size, how text enters and leaves, transitions,
>    colour, backgrounds, 3D.
> 6. Sound: voice or not, voice character, music style and where it hits, SFX count and kinds.
> 7. Attention to detail: small touches a viewer notices.
> 8. How features are listed: count, order, how each is named and proved.
> 9. Ending and call to action.
> 10. The post that carried it (if known) and a short read on why it did or did not travel.
> Plain words, short. Do not recommend copying their claims, wording or story.

If the user picked one example to follow closely, add a frame accurate spec for it:
every shot with start and end time to the frame, camera path, element positions as a share
of the frame, type sizes, colours sampled from frames, the music tempo (measure it with
`scripts/bpm.py`, do not trust a guess), and where each cut lands on the beat.

## 4. Synthesis

Write `launch/research/SYNTHESIS.md` yourself (or with the writer on Max):

1. What the best examples share (with numbers from the analyses).
2. Top 10 techniques to borrow. Techniques only: no names, slogans, characters or assets.
3. What to avoid, including what the user said they dislike.
4. Recommended structure, length, aspect, sound for THIS product, as a beat table:
   time, beat, visual, voice line, on screen caption.
5. Which of the user's features fits which technique.

Show the user the synthesis in plain words (five bullets and the beat table) before
moving to assets.

## Useful measured patterns (from the Munder Difflin study of 12 launch films)

Treat as starting points, check them against the user's examples:
- Proof on screen by second 2; never open on a logo animation or a founder intro.
- One anchor zone for captions across every shot; captions under six words.
- Name and prove a feature in the same 2 to 3 s beat.
- Hard cuts between features; save 3D tilts and push ins for establishing the workspace.
- A visible human: cursor, hands, typing.
- Hold the end card at least 2 s for muted autoplay.
- Single feature films work at 12 to 15 s; multi feature suites at 23 to 50 s.
- Slow talking head explainers and long typographic preambles underperform.
