# Assets: what we have, what we need, how to get it

## 1. Inventory

List every asset the user gave in `launch/assets/INVENTORY.md`: path, type, size,
resolution, licence or owner, and a verdict:
- USE as is (sharp enough at the target size, on brand, licensed).
- FIX (upscale a vector export, crop, recolour within brand rules, cut a clip).
- REPLACE (blurry, wrong ratio, shows private data, not licensed).

Resolution rule: a still must be at least as many pixels as it will fill on screen at the
final zoom. A screen shown at 2x zoom in a 1920 wide film needs about 3840 px of source.

## 2. Gap analysis

From the shot list draft (or the synthesis beat table), list each shot's needs and mark
what is missing: product screens, a flow recording, logo variant, icons, background
texture, 3D object, music, voice, SFX. Write `launch/assets/GAPS.md`.

## 3. Real product screens (preferred for every product shot)

Capture the real product doing the real thing. Options, best first:
1. Web app or Electron app with a debugging port: drive it with Puppeteer or the Chrome
   DevTools Protocol and take high resolution screenshots
   (`Page.captureScreenshot` with `clip.scale: 2` or `3`). Do not set a viewport override
   on a desktop app; it can overflow the real window. Capture at the native window size.
2. A screen recording the user makes (ask for 60 fps, the window only, a clean demo
   account, notifications off, a tidy desktop).
3. Screenshots the user sends.

Tips that saved us time:
- Typing in a real input: one screenshot per typed letter, swapped every 0.02 to 0.04 s
  in the film, reads as real typing and stays sharp.
- Smooth scroll inside a panel: capture the scrolling area at 4 to 8 scroll steps and
  swap them quickly; the last step must match the next full capture exactly.
- Animated parts that wander between captures (avatars, live counters): swap only the
  region that changed, or change state during a fast camera move.
- Use demo data that reads as real (real looking task names, real commands), never
  "Lorem ipsum" or "Test 123".
- Check every capture for private data before it goes in the film (see `review.md`).

## 4. Generated assets (only for what cannot be captured)

Never generate a fake product screen. Generated assets are for backgrounds, textures,
icons, illustrations, 3D props, b roll, music and voice.

For each gap, write a prompt the user can paste into their image, video, music or voice
tool, in `launch/assets/asset-prompts.md` (template in `templates/asset-prompts.md`):
- What it is and where it appears (shot id, size on screen, duration).
- Exact output spec: pixel size, aspect, transparent background or not, file type,
  loop or not, length.
- Style tied to the brand: colours (hex), lighting, material, camera angle, mood words
  from the voice note.
- What must not appear: text, logos, real people, the banned colours.
- Two variants: a safe one and a bolder one.

If this host can generate images itself (some Codex builds can), offer to make them and
show the user before use. Otherwise hand the prompts over and wait for the files.
Write the prompts with the creative writer model (Fable 5.2 or GPT 6.2 Astra).

Prefer code over generation when code can do it well: gradients, grain, glows, particles,
kinetic type, simple 3D (three.js), charts and counters render crisply and edit easily.

## 5. Licences

- Icons: Lucide (ISC), Simple Icons for brand marks (CC0, but trademarks still belong to
  their owners: only show another company's logo when the user says it is fine, for
  example an integrations list).
- SFX: CC0 packs (for example Kenney audio packs, OpenGameArt CC0). Keep a `LICENCES.md`
  next to the sound files.
- Music: only a file the user owns or licensed, or a CC0 track. Using a reference film's
  music is a takedown risk; say so if the user asks for it.
- Fonts: check the licence allows video use.
