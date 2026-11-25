# launch-video skill

Make a product launch film end to end with an AI coding agent, then iterate on it.
The agent interviews you (brand, a one minute voice note about the idea, example videos,
assets, design, spend), studies your examples, finds missing assets and writes prompts to
make them, writes the script and shot list for your approval, builds the film in code with
HyperFrames, renders it, reviews every frame, and delivers a master, a share copy and stems.
Then send notes in any words and it makes the next version.

It is the process the Munder Difflin team uses for its own launch films, with the lessons
from every round of feedback built in (`references/lessons.md`).

Works in Claude Code and Codex.

## Install

With the skills CLI (it asks which agent to install into):

```bash
npx skills add chaitanyagiri/launch-video-skill
npx skills add heygen-com/hyperframes --all   # the HyperFrames skills it builds with
```

Or clone it straight into your skills folder:

```bash
# Claude Code
git clone https://github.com/chaitanyagiri/launch-video-skill ~/.claude/skills/launch-video
# Codex
git clone https://github.com/chaitanyagiri/launch-video-skill ~/.agents/skills/launch-video
```

Needs Node 18+, ffmpeg and Python 3 with numpy. Optional: yt-dlp (download example links),
the agent-reach skill (https://github.com/Panniantong/Agent-Reach) for X, Instagram and
TikTok links, whisper or an ElevenLabs key (voice note transcript).

## Use

- New film: "make a launch video for my app" or `/launch-video create`.
- Change a film: "make scene 2 slower and the background lighter" or `/launch-video iterate`.

The first question is how much to spend: Lean, Standard or Max. It decides how many
examples are studied and which models write and build (Fable 5.2 or GPT 6.2 Astra for
writing, Opus 5.5 at max effort or Fable 5.2 for the build). See
`references/budget-and-models.md`.

Everything lives in a `launch/` folder in your working directory, so any session can pick
up where the last one stopped.

## What it will not do

Invent product screens, put a claim on screen without a source, ship a placeholder, copy
another film's story or music, or clone a real person's voice without consent.

## Licence

MIT, see `LICENSE`.
