# Secret of Mana Revisited: Preproduction Map

## Purpose

This is the authoritative map of the pre-programming package. It points to the current source-of-truth documents and defines the order in which they should be used.

## Current Source Of Truth

- `story structure`: `docs/story-modules.md`
- `repo agent guidance`: `AGENTS.md`
- `factions and power map`: `docs/faction-bible.md`
- `engine and pipeline direction`: `docs/development-framework.md`
- `2D action RPG terminology and reference lane`: `docs/action-rpg-terminology.md`
- `visual language`: `docs/art-direction-brief.md`
- `story and setting expansion`: `docs/story-setting-expansion.md`
- `temple twists and layered quest design`: `docs/temple-turns.md`
- `world texture and peripheral cultures`: `docs/world-texture.md`
- `magic doctrine and weapon schools`: `docs/magic-doctrine.md`
- `visual production decisions`: `docs/visual-production-decisions.md`
- `Chapter 1 environment production kits`: `docs/art/chapter-1-environment-production-kits.md`
- `Chapter 1 sightline pass`: `docs/planning/chapter-1-sightline-pass.md`
- `Godot modular build and story plan`: `docs/planning/godot-modular-build-and-story-plan.md`
- `Water Palace benchmark checklist`: `docs/art/water-palace-benchmark-checklist.md`
- `Portrait Batch 01 spec`: `docs/art/portrait-batch-01-spec.md`
- `Forbidden Falls combat benchmark`: `docs/art/forbidden-falls-combat-benchmark-checklist.md`
- `content conventions and IDs`: `docs/content-conventions.md`
- `content templates`: `docs/templates/content-templates.md`
- `chapter 1 package`: `docs/chapters/chapter-01-falls-to-pandora.md`
- `chapter 2 package`: `docs/chapters/chapter-02-pandora-under-strain.md`
- `chapter 3 package`: `docs/chapters/chapter-03-gaias-navel-and-lost-memory.md`
- `chapter 4 package`: `docs/chapters/chapter-04-the-earth-below-remembers.md`
- `chapter 5 package`: `docs/chapters/chapter-05-the-witch-and-the-ruins.md`
- `chapter 6 package`: `docs/chapters/chapter-06-forests-above-the-clouds.md`
- `chapter 7 package`: `docs/chapters/chapter-07-bloom-rot-and-remembrance.md`
- `chapter 8 package`: `docs/chapters/chapter-08-salt-law-and-empty-wells.md`
- `chapter 9 package`: `docs/chapters/chapter-09-the-sandship-and-the-split-towns.md`
- `chapter 10 package`: `docs/chapters/chapter-10-the-moon-kept-truth.md`
- `chapter 11 package`: `docs/chapters/chapter-11-crowns-borrowed-from-light.md`
- `chapter 12 package`: `docs/chapters/chapter-12-ledgers-of-the-sun.md`
- `Pandora character sheets`: `docs/characters/pandora-character-sheets.md`
- `Empire character sheets`: `docs/characters/empire-character-sheets.md`
- `core cast sheets`: `docs/characters/mana-core-character-sheets.md`
- `temple dossiers`: `docs/temples/`
- `Dyluck mission brief`: `docs/briefs/dyluck-mission-brief.md`
- `early progression locks`: `docs/briefs/early-progression-locks.md`
- `subculture briefs`: `docs/briefs/subculture-briefs.md`
- `first temple authority dispute scene`: `docs/scenes/water-palace-vs-falls-shrine-dispute.md`
- `tracker and open items`: `docs/planning/task-tracker.md`, `docs/planning/open-items.md`
- `project chapter-authoring skill`: `.agents/skills/somr-chapter-module-authoring/SKILL.md`
- `project visual-style skill`: `.agents/skills/somr-visual-style-authoring/SKILL.md`
- `Godot bootstrap rules`: `docs/godot-bootstrap.md`
- `local Godot setup guide`: `docs/godot-local-setup.md`
- `Godot project shell`: `game/project.godot`
- `playable prototype runtime`: `game/scenes/main.tscn`, `game/scripts/prototype/`
- `runtime editorial data bridge`: `game/scripts/data/`
- `structured scene mirrors`: `game/data/scenes/`
- `structured quest mirrors`: `game/data/quests/`

## Canonical Decisions Locked So Far

- Engine: `Godot 4.4+`
- Art style: dense, ornate, semi-overhead 2D action RPG presentation with jump-capable traversal and no remake-style 3D presentation
- Tone: melancholic mythic adventure with political weight
- Chapter 1 boundary: `Potos -> exile -> wilderness transition -> Water Palace approach -> Pandora arrival and first political contact`
- Broader Mana-series motifs are being used as inspiration, not assumed direct continuity unless explicitly written into this project
- First benchmark environment is locked to the `Water Palace inner chamber`
- First Chapter 1 combat benchmark is locked to the `Forbidden Falls seal breach arena`
- Dialogue portraits are locked to `96x96` detailed pixel portrait panels
- Portrait Batch 01 and expression tiers are locked
- The first benchmark room now has an execution checklist
- Narrative source of truth remains Markdown during preproduction
- Structured content should later mirror into JSON or YAML after templates stabilize
- Chapters 1 and 2 now have scene-level and quest-level YAML mirrors for implementation planning
- Chapters 1-12 now have chapter-level YAML mirrors for implementation planning
- Tasnica remains rumor-only in Chapters 1-2 and becomes concrete through sky-route correspondence in Chapter 6
- the initial Godot shell now exists under `game/`
- the first prototype runtime slice now exists for controller, dialogue, and benchmark-map work
- the prototype now reads Chapter 1-2 scene and quest mirrors for in-engine benchmark metadata
- the prototype now executes a linear Chapter 1 scene sequence, active quest handoff, and resulting flag updates
- the prototype now replaces manual scene advancement with in-world completion triggers and restores saved Chapter 1 runtime state
- the prototype now hands off from Chapter 1 into Chapter 2 and uses a dedicated Pandora benchmark map for the second playable slice
- every Chapter 1 scene now routes through a dedicated benchmark or a scene-specific story stage instead of the generic test hall fallback
- chapter packaging is locked to `one module per chapter`
- runtime content authority is locked to `Markdown first, YAML mirror second`
- build-target defaults are locked to `dev_all_content`, `review_slice_ch01`, and `review_slice_ch01_ch02`
- story safety is locked to `validators + dependency declarations`
- placeholder stills remain part of the modular chapter pipeline

## Canonical Terminology

- `Mana`: the world-binding force that functions as ecology, memory, authority, and magical energy
- `Mana-lineage action RPG`: the project's broad identity; use for the Secret of Mana plus Alundra plus Terranigma reference stack
- `semi-overhead field view`: the default exploration and combat presentation lane
- `map-native combat`: live combat occurring inside explorable maps rather than in separate battle scenes
- `jump-capable traversal`: jumping is a real movement verb for exploration and combat support
- `ring-command layer`: radial or fast-pause ability selection for spells, items, and party functions
- `combat lane`: the readable pocket of space where enemy pressure, hazards, and movement interact
- `Temple Orders`: regional custodians of mana practice, not branches of one unified church
- `Gemma Tradition`: the inherited sword-and-seal guardianship structure represented by Jema and earlier keepers
- `Imperial Blocs`: the internal power groupings inside the Empire of Vandole
- `Corruption`: mana destabilization manifesting in living regions, bodies, and spirits
- `Necromancy`: deliberate Thanatos-linked manipulation of death, possession, and grief
- `Engineered Mana Abuse`: artificial or imperial extraction, rerouting, or weaponization of mana systems

## Working Order

1. Use `story-modules` and `faction-bible` to shape narrative decisions.
2. Use `AGENTS.md` to confirm locked architecture, build, story-safety, and AI-workflow defaults.
3. Use `action-rpg-terminology` before describing combat, traversal, camera, or scene types.
4. Use `character sheets` when writing scenes or quest logic.
5. Use `temple-turns`, `world-texture`, `subculture briefs`, and `magic-doctrine` when expanding regions and sacred sites.
6. Use `character sheets`, the `Dyluck mission brief`, and the temple dispute scene when writing Pandora fallout and Chapter 3.
7. Use `content conventions` and `templates` before drafting new content docs.
8. Use the project skills when the task is primarily chapter-safe content work or visual/style work.
9. Use the `chapter 1 package` and `chapter 2 package` as the production benchmark for later chapters.
10. Use the structured `game/data/scenes/` and `game/data/quests/` mirrors when turning stable editorial scenes into implementation-facing content.
11. Use `godot-bootstrap` when creating the project shell and mirrored data folders.

## Minimum Definition Of "Ready To Start Programming"

The project is ready to begin systems implementation when:

- Chapter 1 scenes and quests are stable enough to build without narrative reinterpretation
- Chapter 2 is stable enough to continue chapter-by-chapter narrative production
- Chapter 3 is stable enough to carry the project into Popoi's introduction and the earth-route arc
- Chapter 4 is stable enough to carry the project back toward the haunted crisis route
- Chapter 5 is stable enough to reconnect earth-route fallout to Elinee, ruins, and coordinated corruption
- Chapter 6 is stable enough to widen the story into Upper Land, the Wind Sanctuary, and the first real sky-route political horizon
- Chapter 7 is stable enough to connect temple restoration to revived regional industry and openly rising imperial attention
- Chapter 8 is stable enough to make imperial logistics, civic scarcity, and occupation visible as a lived system
- Chapter 9 is stable enough to turn transport, split-town occupation, and Mana Engineering logistics into one continuous imperial machine
- Chapter 10 is stable enough to carry the project from imperial transport systems back into the Moon Palace and Tasnica truth-governance arc
- Chapter 11 is stable enough to move the project into Tasnica alliance politics and the Light Palace legitimacy war
- Chapter 12 is stable enough to carry the project into the Light Palace legitimacy engine and open the Dark Palace route
- faction leaders and recurring officers are named and placed in story flow
- core cast sheets are stable enough to drive scene writing
- temple dossiers define the sacred network in production-ready terms
- visual benchmark and portrait format are chosen
- the first benchmark checklist exists and can drive art production
- the first combat benchmark room is defined
- art requirements for the first benchmark area are defined
- the first portrait production batch is defined
- IDs, flags, and content templates are locked
- the first mirrored `game/data` manifests exist for chapters, cast, factions, regions, temples, and story flags
- the first mirrored `game/data` scene and quest files exist for Chapters 1 and 2
- the Godot folder scaffold, bootstrap rules, runtime wrapper, prototype scenes, editorial YAML loader, and first persisted Chapters 1-2 runtime pass are in place
- remaining open items are small enough that they do not block controller, dialogue, quest, and map framework work
