# Intake: the questionnaire

Goal: everything needed to build the film is known before research starts. Ask in rounds,
not all at once. Use the host's question tool when it has one (Claude Code:
AskUserQuestion, up to 4 questions a call; Codex: ask in chat with numbered questions).
Offer a sensible default for every question so the user can answer "default".
Save answers to `launch/intake.json` (shape in `templates/intake.json`) after each round.

## Round 0: spend (always first)

See `budget-and-models.md`. One question: Lean, Standard, Max, or Custom.

## Round 1: the brand

1. Product and brand name, exactly as it should appear on screen (case, spacing).
2. One sentence: what the product does and for whom.
3. What is launching: the whole product, a version, or one feature? Version number if any.
4. Website or download URL for the end card.
5. Logo files (SVG best, then PNG at 1024 px or more), both light and dark versions if they exist.
6. Brand colours (hex), fonts (name and file or Google Fonts name), and any brand guide link.
7. Tone in three words (for example: calm, precise, playful).

## Round 2: the idea, in their own voice

Ask the user to talk for about a minute about the film they imagine: the feeling, the
story, the one thing a viewer must remember, what they hate in launch videos.

How to take it, in order of preference:
1. A voice memo file (m4a, mp3, wav). Ask for the path, then run
   `scripts/transcribe.sh <file> launch/intake/voice-note.txt`.
2. Dictation into the chat (macOS dictation, Windows voice typing, or any dictation app).
3. A typed paragraph.

Read the transcript back as five bullet points ("Here is what I heard") and ask what is
wrong or missing. Keep the raw transcript; the user's own phrases are the best source for
on screen words.

## Round 3: examples

1. Two to twelve example videos they like (links or files). For each: what they like about
   it, in a few words (the cut, the type, the sound, the camera, the pace).
2. One or two examples they dislike, and why. These are as useful as the good ones.
3. Should one example be followed closely (a remake of its structure with their product),
   or should the film borrow from all of them? A close remake still copies technique only.

## Round 4: product and assets

1. Can I capture the real product? How: a running app on this machine, a web URL, a
   staging build, screenshots, or screen recordings the user makes.
2. Which features go in, ranked. Three to five is the sweet spot for 30 to 50 s.
3. For each feature: the real flow that proves it (what to click, what appears).
4. Existing assets: screenshots, recordings, product photos, team photos, icons,
   illustrations, music they own or licensed, voice recordings. Paths please.
5. Anything private that must never be on screen (customer names, real emails, internal
   paths, prices, unreleased features).

## Round 5: format and sound

1. Where it will be posted (X, LinkedIn, Instagram, YouTube, Product Hunt, website hero).
   This sets aspect ratio: 16:9 (1920x1080) for X, YouTube and web; 9:16 (1080x1920) for
   Reels, Shorts, TikTok; 1:1 when asked. Offer both 16:9 and 9:16 if they post widely.
2. Length target (default 30 to 45 s; one feature 12 to 15 s).
3. Frame rate (default 60 fps for UI motion, 30 fps for vertical social).
4. Sound: music bed, voiceover, SFX only, or silent (the user adds music later).
   Voiceover: the user's own recording, or a stock synthetic voice (never a clone of a
   real person without their consent). Music: a file they own or licensed, or none.
5. Light or dark look, or both cuts.

## Round 6: words and rules

1. Lines that must appear (tagline, call to action).
2. Words, claims or comparisons that must never appear (competitor names, "free" if not
   free, numbers without a source).
3. Brand rules for every frame: banned colours, banned punctuation (for example no dashes),
   casing rules, emoji yes or no.
4. Who approves: only the user, or someone else too? Deadline?

## Close the intake

Write `launch/BRIEF.md` from `templates/BRIEF.md`: one page, plain words. Show it and ask
"Is this right?" Do not start research until the user says yes.
