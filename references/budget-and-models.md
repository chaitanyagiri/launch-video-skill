# Spend and models

## The spend question (ask first)

"How much should I spend on this film? It sets how many examples I study, which models
write and build it, and how many review passes it gets."

| Tier | Examples analysed | Writer | Builder | Review | Rough use |
|---|---|---|---|---|---|
| Lean | up to 3, in this session | this session's model | this session's model at high effort | 1 self review | lowest; good for a single feature film |
| Standard (default) | up to 6, one helper each | Fable 5.2 | Opus 5.5 at max effort | 1 review by a second helper | moderate |
| Max | up to 12, one helper each | Fable 5.2 at max effort | Fable 5.2 at max effort, scene groups in parallel | 2 rounds: a cross review on the other vendor's model, then a final frame check | highest; launch day hero film |
| Custom | user sets each column | | | | |

Tell the user the tier is a ceiling, not a target: stop early when quality is there.
Video renders run on the user's machine and cost time, not tokens; say roughly how long
(a 45 s 1080p60 film renders in about 2 to 5 minutes on a laptop).

## Routing table

| Job | Claude Code | Codex |
|---|---|---|
| Creative writing (script, voice lines, titles, post text) | `claude-fable-5-2` (Agent tool `model: "fable"`) | `gpt-6.2-astra`, reasoning effort high (xhigh on Max) |
| Normal motion graphics build | `claude-opus-5-5` at max effort (Agent tool `model: "opus"`, `effort: "max"`) | `gpt-6.2-astra`, reasoning effort high |
| High quality motion graphics build (Max tier) | `claude-fable-5-2` at max effort | `gpt-6.2-astra`, reasoning effort xhigh |
| Example analysis | a model that watches video natively if available (for example a Gemini CLI); else Opus 5.5 with frames and transcript | `gpt-6.2-astra` with frames and transcript |
| Review and frame check | the model that did NOT build the scene | the model that did NOT build the scene |
| Downloads, ffmpeg, captures | no model needed: scripts in `scripts/` | same |

If a model is not available on the user's plan, say which one you are using instead and why.
In Codex, if `gpt-6.2-astra` is refused, the CLI may be old: suggest `codex update`.

## How to spawn helpers

Helpers cannot ask you questions mid run. Give each a complete brief: the goal, the exact
input files, the exact output path, the rules from `lessons.md` that apply, and "report the
output path when done".

Claude Code:
- Agent tool with `model` and, for builds, `effort` (this skill explicitly asks for it):
  `Agent({ description, prompt, model: "fable" })`, `Agent({ ..., model: "opus", effort: "max" })`.
- Launch independent helpers in one message so they run in parallel (one per example video,
  or one per scene group on Max).
- Headless alternative: `claude -p --model claude-fable-5-2 "<brief>"`.

Codex:
- If multi agent is enabled in this Codex build, spawn sub agents with the brief.
- Otherwise run each helper as its own process:
  `codex exec -m gpt-6.2-astra -c model_reasoning_effort="high" "<brief>"`
  (use `"xhigh"` on Max). Run independent ones in the background and wait for all.

Cross vendor review (Max tier): if both CLIs are installed, the reviewer runs on the other
vendor (`codex exec ...` from Claude Code, or `claude -p ...` from Codex). If only one is
installed, use a fresh helper on a different model of the same vendor.

## Effort per step

| Step | Lean | Standard | Max |
|---|---|---|---|
| Intake | this session | this session | this session |
| Research | inline, frames only | one helper per example, then a synthesis | same, plus a close beat by beat spec of the closest example |
| Script | this session | Fable writer, 2 options | Fable writer, 3 options, the user picks |
| Build | this session | one Opus builder | Fable builders per scene group, one integrator |
| Review | self | one reviewer | cross vendor reviewer, then a final frame check |
