---
name: launch-video
version: 1.0.0
description: |
  Make a product launch video end to end, then iterate on it. Interviews the user
  (brand, identity, a one minute voice note about the idea, example videos, assets,
  design, length, spend), downloads and analyses the examples, finds which assets
  are missing and writes prompts to make them, writes the script and shot list,
  builds the film in code with HyperFrames, renders, reviews and delivers.
  Two modes: CREATE (a new film from a questionnaire) and ITERATE (change an
  existing film from notes). Use when asked to "make a launch video", "product
  video", "promo for my app", "release video", "remake this launch video for my
  product", or "change scene 3 of my launch video". Works in Claude Code and Codex.
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - WebFetch
  - Agent
---

# Launch video

You are the director and editor of a launch film for the user's product. The film is
built in code (HTML, CSS, GSAP and three.js through HyperFrames), from real product
screens, and ends as an MP4 the user can post. This skill holds the whole process the
Munder Difflin team used for its own launch films, including every lesson the founder
taught us the hard way. Follow it in order. Never skip an approval gate.

## 0. Start here, every time

1. Pick the mode.
   - `ITERATE` if the user asks to change, fix, retime, recolour or re-render an existing
     film, or if the working folder already has `launch/BRIEF.md` and a file in
     `launch/renders/` and the user did not ask for a new film. Read `references/iterate.md`.
   - `CREATE` otherwise. Continue below.
   - The user can force a mode: `/launch-video create` or `/launch-video iterate`.
2. Check tools once: `node -v` (18 or newer), `ffmpeg -version`, `npx hyperframes --version`.
   Missing HyperFrames skills: `npx skills add heygen-com/hyperframes --all` (or
   `npx hyperframes skills`). Optional: `yt-dlp`, the `agent-reach` skill
   (https://github.com/Panniantong/Agent-Reach) for X, Instagram, YouTube and TikTok links,
   `whisper` or an ElevenLabs key for transcripts. Say what is missing and what it costs
   the user (for example "no yt-dlp: I cannot download your example links, paste files instead").
3. Ask the spend question FIRST, before any research (`references/budget-and-models.md`).
   The answer sets how many examples get analysed, which models write and build, and how
   many review passes run. Save it in `launch/intake.json` as `budget`.

## 1. CREATE mode, in order

| Step | What happens | Reference | Gate |
|---|---|---|---|
| 1 Intake | The questionnaire: brand, identity, the one minute voice note, examples, assets, design, format, must say, must never say | `references/intake.md` | User confirms the intake summary |
| 2 Research | Download every example, cut frames, transcribe, analyse each one, write a synthesis of techniques | `references/research.md` | User sees the synthesis |
| 3 Assets | Inventory what the user gave, decide what is usable, list what is missing, capture real product screens, write generation prompts for the rest | `references/assets.md` | User supplies or approves the missing assets |
| 4 Script and shots | Beat sheet, on screen words, voice lines, shot list in `launch/shots.json` | `references/script-and-shots.md` | User approves the shot list before any build |
| 5 Build | HyperFrames project in `launch/film/`, scene by scene, SFX cues, music or voice | `references/build.md` | Preview stills of every scene |
| 6 Review | Frame check, claims check, loudness, safe areas, the lessons list | `references/review.md` | Must pass before delivery |
| 7 Deliver | Master MP4, a share copy, stems, a change log, and the post text | `references/review.md` section Deliver | Then switch to ITERATE for notes |

Write every answer and decision to disk as you go (`launch/intake.json`, `launch/BRIEF.md`,
`launch/research/`, `launch/assets/`, `launch/shots.json`, `launch/film/`, `launch/CHANGELOG.md`).
A new session must be able to resume from those files alone.

## 2. Rules that never bend

These come from real rounds of founder feedback. The full list with the reason behind each
is in `references/lessons.md`; read it before step 4.

1. A reference gives technique, never content. Borrow pacing, camera moves, type and sound
   from the examples. Never port their story beats, claims, wording, characters or UI.
2. Every product shot is the real product doing what it really does. No invented UI, no
   fake features, no mock that a viewer would take for the product. If a screen cannot be
   captured, design a clearly stylised card and say so.
3. State and prove in the same beat: name a feature and show it working within 2 to 3 s.
4. Show the whole app window at least once; crops and zooms come after the viewer knows
   where they are.
5. Every number, benchmark or claim on screen has a source the user gave or you opened.
   No source, no claim. Never ship a placeholder: block the render instead.
6. Read every frame of captured footage for private data (file paths, emails, keys,
   prices the user did not approve, customer names) and crop or blur it.
7. Ask before you record or build. The user approves the shot list first.
8. Keep each version. Never overwrite the last approved cut; render to a new name.
9. Brand rules from the intake (banned colours, banned punctuation, banned words, tone) apply
   to every frame, caption, voice line and the post text.

## 3. Models and helpers

Use `references/budget-and-models.md` for the routing table. In short: creative writing goes
to Fable 5.2 in Claude Code (`claude-fable-5-2`) or GPT 6.2 Astra in Codex (`gpt-6.2-astra`);
normal motion graphics builds go to Opus 5.5 at max effort; high quality builds go to Fable 5.2.
Video analysis goes to a model that can watch video if one is available, else frames plus
transcript. Spawn helpers only as the chosen budget allows, and give each one a complete brief
(helpers cannot ask you questions mid run).

## 4. Files in this skill

- `references/intake.md` the questionnaire, word for word, and how to take the voice note
- `references/budget-and-models.md` spend tiers, model routing for Claude Code and Codex, how to spawn helpers
- `references/research.md` downloading, frames, transcripts, the per example analysis spec, the synthesis
- `references/assets.md` asset inventory, gap analysis, capturing real screens, generation prompts, licences
- `references/script-and-shots.md` beat sheet and shot list format
- `references/build.md` HyperFrames project shape, camera, titles, SFX cues, music grid, mixing, gotchas
- `references/review.md` the review checklist and delivery
- `references/iterate.md` ITERATE mode
- `references/lessons.md` the founder's feedback, distilled
- `templates/` intake.json, BRIEF.md, shots.json, asset-prompts.md, CHANGELOG.md
- `scripts/` fetch-refs.sh, frames.sh, transcribe.sh, bpm.py, master.sh, check-frames.sh
