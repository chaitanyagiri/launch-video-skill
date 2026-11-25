# Review and delivery

Review with a model that did not build the scene (see `budget-and-models.md`). Nothing
ships until every line below passes or the user waives it in writing.

## Frame check

Run `scripts/check-frames.sh launch/film/renders/<name>.mp4 24` to pull 24 evenly spaced
frames and a contact sheet, plus one frame at the middle of every shot in shots.json.
Look at every frame:

1. Every product shot is a real capture or a clearly designed card. Nothing that a
   viewer would mistake for a feature the product does not have.
2. No private data: file paths, usernames, emails, keys, tokens, internal URLs, customer
   names, prices the user did not approve, test counters ("100 results" from a test fixture).
3. Brand rules: banned colours (sample suspicious pixels), banned punctuation in every
   caption, casing, fonts.
4. Text fits: no clipped words, no titles wrapping when they should be one line, safe
   margins (keep text 5 percent in from the edges; on 9:16 keep the bottom 20 percent clear
   of key text because of the app's own buttons).
5. Every number and claim on screen is in the source list. No placeholder text anywhere:
   "TODO", "Lorem", "[name]", "XX%". If one exists, stop and fix it; never deliver it.
6. The hook shows the product or the problem by second 2. The end card holds 2 s or more.
7. Transitions: no ghost edges, no one frame flashes of the previous scene, no element
   visible before its entrance.

## Sound check

- Loudness: `ffmpeg -i <file> -af ebur128 -f null -` reads integrated LUFS and true peak.
  Target -14 LUFS and -1 dBTP for social, unless the user asked for a quieter mix.
- Voice onsets land within 0.1 s of the plan; read the transcript of the final file
  against the script.
- SFX land on their action (a click on the click frame, not a beat late).

## Deliver

1. Master: `renders/<product>-launch-v<N>.mp4` (1080p, 60 fps or as briefed).
2. Share copy: `scripts/master.sh --share` re-encodes to about crf 19, small enough for chat
   apps and email (many cap uploads at 25 to 30 MB).
3. Stems: voice, SFX, music, and a silent master, so the user can remix.
4. Any extra aspect the user asked for (9:16 cut reframed by design, not a centre crop of the 16:9).
5. A cover frame: one strong still for the thumbnail.
6. The post text, written by the writer model from the same feature order as the film.
7. `CHANGELOG.md` updated, and a short note to the user: what the film shows, length,
   where the files are (full paths), what was designed rather than captured, any open
   question (an unsourced claim left out, a licence to confirm).

Then say: "Send me notes in any words, by timecode or scene, and I will make the next version."
That switches to ITERATE mode.
