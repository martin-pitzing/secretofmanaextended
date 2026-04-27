# Chapter 1 Character Sandbox Art Contract

This folder is the current drop zone for Chapter 1 placeholder character sprites that can be reviewed in the `Chapter 1 Character Sandbox`.

Use these support files together:

- `game/art/ch01/characters/sandbox-placeholder-guide.md`
- `game/art/ch01/characters/sandbox-placeholder-question-set.md`
- `game/art/ch01/characters/sandbox-placeholder-creation-engine.yaml`
- `tools/generate-ch01-sandbox-placeholders.ps1`
- `tools/generate-randi-hero-sprites.ps1`

The sandbox currently looks for these optional files:

- `game/art/ch01/characters/randi/sandbox_placeholder.png`
- `game/art/ch01/characters/potos_villager/sandbox_placeholder.png`
- `game/art/ch01/characters/water_palace_attendant/sandbox_placeholder.png`
- `game/art/ch01/characters/pandora_refugee/sandbox_placeholder.png`
- `game/art/ch01/characters/rabite_echo/sandbox_placeholder.png`

If a file is present, the visible sandbox actor will use it.

If a file is missing, the sandbox falls back to the current low-fi polygon actor stand.

To regenerate the current first-pass placeholder sprites, run:

```powershell
.\tools\generate-ch01-sandbox-placeholders.ps1
```

The same command also refreshes:

- `game/art/ch01/characters/sandbox_placeholder_sheet.png`

For the current Randi hero-spec locomotion pass, run:

```powershell
.\tools\generate-randi-hero-sprites.ps1
```

That refreshes:

- `game/art/ch01/characters/randi/hero/*.png`
- `game/art/ch01/characters/randi/hero/randi_hero_sheet.png`

Current sandbox goals:

- test character-to-player spacing
- test dialogue interaction with visible actors
- test Chapter 1 costume and silhouette reads
- test cute-monster readability against combat pressure
- give art production a stable runtime target before chapter scenes deepen

Recommended placeholder sprite rules:

- use one centered sprite per file for now
- prioritize silhouette and palette before animation
- keep characters readable against semi-overhead field presentation
- favor Chapter 1 regional identity over generic fantasy clothing

Per-target briefs now live in:

- `game/art/ch01/characters/randi/brief.md`
- `game/art/ch01/characters/randi/reference-sheet-notes.md`
- `game/art/ch01/characters/randi/hero/README.md`
- `game/art/ch01/characters/randi/source_pages/README.md`
- `game/art/ch01/characters/potos_villager/brief.md`
- `game/art/ch01/characters/water_palace_attendant/brief.md`
- `game/art/ch01/characters/pandora_refugee/brief.md`
- `game/art/ch01/characters/rabite_echo/brief.md`
