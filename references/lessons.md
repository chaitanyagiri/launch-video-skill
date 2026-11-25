# Lessons from the Munder Difflin launch films

Every line here came from a real round of founder feedback on our own launch films
(September to November 2026: the first launch film, eight versions; the Halloween release
film; the 0.5.7 film; the "Pro is now free" story; the 0.5.10 film; and a seven version
remake of a reference launch film). Each has the reason, so you can apply it to a new
product rather than follow it blindly.

## Story and content

1. **A reference gives technique, not content.** We once copied a reference film's story
   beats (windows flying into desks) and invented UI to match. Rejected. Borrow pacing,
   camera, type and sound; every shot must be the real product doing what it really does.
2. **Real screens only.** A viewer who downloads the product must find what the film showed.
   When a screen cannot be captured, make a designed card that is obviously a design.
3. **Sell the whole app.** Show the entire app window at least once. A cropped corner with no
   context does not tell a viewer what they are looking at.
4. **State and prove in one beat.** Name a feature and show it working in the same 2 to 3 s.
5. **No unsourced claim.** A benchmark card with bars and "2x" was built, then pulled because
   no source supported it. The safe default build leaves an unsourced claim out; a version
   with it can exist only with a visible source line. Make the render refuse an empty
   citation field rather than trusting yourself to remember.
6. **No placeholders, ever.** People forward files without reading the message. If a field is
   missing, stop the render, do not ship "[source]".
7. **Say only what is true today.** Do not film a feature that has not shipped in the build
   people can download. Do not show a key shortcut or platform claim you have not tested.
8. **Words the brand never uses.** Respect the user's banned words and claims everywhere,
   including the post text (for us: no dashes, no price on screen, "free and open source"
   only where it is true).

## Direction and process

9. **Ask before you record.** The founder reviews the shot list before any capture or build.
10. **Let the user direct.** When a cut misses, offer a plain English shot by shot brief they
    can fill in (screen, what happens, camera, zoom, cursor, pop out, text, transition), and
    build from their version, not yours.
11. **When the user says "just decide", decide.** Some rounds the founder wanted one shot:
    "take decisions, just give me the video." Then make the calls, deliver, and list the
    calls you made.
12. **Keep every version.** Render to a new name each round, keep the source of the previous
    cut, and write one changelog line per change. Notes often go back a version.
13. **Measure, do not trust a spec.** A frame spec said 130.4 BPM; the music measured 128.0.
    Cutting on the wrong number drifts every cut. Measure tempo, loudness and timings yourself.

## Look

14. **Big, one line titles.** Titles read best at one size across the film, one line, measured
    to fit. Two lines only when one line would be unreadably small.
15. **Lift, do not frame.** A component lifted over a blurred app: rounded box and shadow
    only. A grey border around it looked cheap.
16. **Even borders only.** Never a thicker border on one edge of a card; 1 px all round, and
    show status with a chip, not a coloured edge.
17. **Backgrounds the user picks.** Our founder rejected two bold accent backgrounds in a row
    and went back to the original light paper. Offer the safe option first, and show a
    still of each before rendering the whole film in it.
18. **Whips without blur.** Both scenes slide the full width together. Blur plus a partial
    move read as a white ghost on the edge.
19. **No logo intros, no long preambles.** Product on screen by second 2.
20. **Hold the end card.** At least 2 s, so muted autoplay viewers catch the name and URL.
21. **Pace by feel, then by the music.** First scene a beat longer than you think, fast
    middle, cuts on bars. Typing and name cycles look best fast: about 0.02 to 0.03 s a letter.

## Sound

22. **Fewer SFX.** Our first full mix had 112 hits; the approved ones had 52 to 80. No whoosh
    on every title.
23. **Music the user owns.** Using a reference film's track is a takedown risk.
24. **Stems always.** Founders often add their own music; give them voice and SFX stems.
25. **Stock voices, never clones,** unless the person consents. Audition three or four.

## Delivery

26. **Read every frame before delivery** for paths, emails, keys, prices and test data.
27. **Send a share copy** small enough for chat apps (under about 25 MB), plus the master.
28. **Full file paths** in every report, so the user can open them.
29. **Heavy renders on power.** Long renders on a laptop battery die halfway; plug in first.
