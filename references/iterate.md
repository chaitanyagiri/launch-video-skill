# ITERATE mode

For a film that already exists (made by this skill or not). Goal: turn the user's notes
into a new version fast, change only what was asked, and never lose a version.

## 1. Load the project

- Read `launch/BRIEF.md`, `launch/shots.json`, `launch/CHANGELOG.md` and the latest render.
- If the film was not made by this skill, ask for the project folder or the source files.
  If only an MP4 exists, say plainly that edits are limited to cuts, retiming, overlays and
  sound, unless the film is rebuilt (offer CREATE with this film as the example to follow).
- Run `npx hyperframes timeline --json` in `launch/film/` to see what plays when, instead of
  reading every scene file.

## 2. Turn notes into a change list

Users give notes in loose words ("scene 1 is too slow", "make the names faster", "the yellow
is wrong", "drag should be slower"). For each note write one line in
`launch/notes/v<N+1>.md`:

| # | Note (their words) | Where (scene id, timecode) | Change (exact) | Side effects |

Examples of exact changes: "scene s1 played length 1.5 s to 1.97 s; all later cuts move by
+0.47 s", "names type at 0.024 s a letter (was 0.04), hold 0.35 s (was 0.59)",
"background token --bg #F7F5F1 (was #F1B53D)". Flag notes that conflict with the brief or
the lessons list, and ask once before going against a rule (for example a claim with no
source).

If a note is ambiguous ("make it pop"), offer two concrete readings with a still for each.

## 3. Make the changes

- Snapshot first: copy the current composition to `versions/index-v<N>.html.txt` (and any
  changed source files) so the previous cut can be rebuilt.
- Change the fewest files. Retime through played lengths and the music bar grid, not by
  editing every tween.
- When the music bed has to get longer or shorter, add or remove whole bars (see build.md).
- Re-run lint and check, render to a NEW name (`v<N+1>`), never over the previous file.

## 4. Check and report

- Frame check only the scenes that changed plus one frame either side of every moved cut;
  run the full review list from `review.md` before calling it final.
- Update `CHANGELOG.md`: version, date, each change in one line, the file path.
- Tell the user: what changed (their notes, one line each), what did not change on purpose
  and why, the new file paths (master and share copy), and anything still open.

## Modes inside ITERATE

- `quick`: one or two small notes; this session does them, no helpers.
- `round`: a full round of notes; the builder model does them, a reviewer checks.
- `branch`: the user wants two directions (for example a light and a dark cut, or two
  background colours); build both from the same base as `v<N+1>a` and `v<N+1>b`.

The user can say which; default is `quick` for up to three small notes, else `round`.
