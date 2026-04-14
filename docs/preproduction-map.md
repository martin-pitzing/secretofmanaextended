# Secret of Mana Revisited: Preproduction Map

## Purpose

This is the authoritative map of the pre-programming package. It points to the current source-of-truth documents and defines the order in which they should be used.

## Current Source Of Truth

- `story structure`: `docs/story-modules.md`
- `factions and power map`: `docs/faction-bible.md`
- `engine and pipeline direction`: `docs/development-framework.md`
- `visual language`: `docs/art-direction-brief.md`
- `story and setting expansion`: `docs/story-setting-expansion.md`
- `temple twists and layered quest design`: `docs/temple-turns.md`
- `world texture and peripheral cultures`: `docs/world-texture.md`
- `magic doctrine and weapon schools`: `docs/magic-doctrine.md`
- `visual production decisions`: `docs/visual-production-decisions.md`
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
- `Pandora character sheets`: `docs/characters/pandora-character-sheets.md`
- `Empire character sheets`: `docs/characters/empire-character-sheets.md`
- `core cast sheets`: `docs/characters/mana-core-character-sheets.md`
- `temple dossiers`: `docs/temples/`
- `Dyluck mission brief`: `docs/briefs/dyluck-mission-brief.md`
- `early progression locks`: `docs/briefs/early-progression-locks.md`
- `subculture briefs`: `docs/briefs/subculture-briefs.md`
- `first temple authority dispute scene`: `docs/scenes/water-palace-vs-falls-shrine-dispute.md`
- `tracker and open items`: `docs/planning/task-tracker.md`, `docs/planning/open-items.md`
- `Godot bootstrap rules`: `docs/godot-bootstrap.md`
- `Godot project shell`: `game/project.godot`
- `structured scene mirrors`: `game/data/scenes/`
- `structured quest mirrors`: `game/data/quests/`

## Canonical Decisions Locked So Far

- Engine: `Godot 4.4+`
- Art style: dense, ornate, top-down pixel fantasy with no remake-style 3D presentation
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
- Tasnica remains rumor-only in Chapters 1-2 and becomes concrete through sky-route correspondence in Chapter 6
- the initial Godot shell now exists under `game/`
- Godot scaffolding is part of pre-programming setup, but gameplay code is still out of scope

## Canonical Terminology

- `Mana`: the world-binding force that functions as ecology, memory, authority, and magical energy
- `Temple Orders`: regional custodians of mana practice, not branches of one unified church
- `Gemma Tradition`: the inherited sword-and-seal guardianship structure represented by Jema and earlier keepers
- `Imperial Blocs`: the internal power groupings inside the Empire of Vandole
- `Corruption`: mana destabilization manifesting in living regions, bodies, and spirits
- `Necromancy`: deliberate Thanatos-linked manipulation of death, possession, and grief
- `Engineered Mana Abuse`: artificial or imperial extraction, rerouting, or weaponization of mana systems

## Working Order

1. Use `story-modules` and `faction-bible` to shape narrative decisions.
2. Use `character sheets` when writing scenes or quest logic.
3. Use `temple-turns`, `world-texture`, `subculture briefs`, and `magic-doctrine` when expanding regions and sacred sites.
4. Use `character sheets`, the `Dyluck mission brief`, and the temple dispute scene when writing Pandora fallout and Chapter 3.
5. Use `content conventions` and `templates` before drafting new content docs.
6. Use the `chapter 1 package` and `chapter 2 package` as the production benchmark for later chapters.
7. Use the structured `game/data/scenes/` and `game/data/quests/` mirrors when turning stable editorial scenes into implementation-facing content.
8. Use `godot-bootstrap` when creating the project shell and mirrored data folders.

## Minimum Definition Of "Ready To Start Programming"

The project is ready to begin systems implementation when:

- Chapter 1 scenes and quests are stable enough to build without narrative reinterpretation
- Chapter 2 is stable enough to continue chapter-by-chapter narrative production
- Chapter 3 is stable enough to carry the project into Popoi's introduction and the earth-route arc
- Chapter 4 is stable enough to carry the project back toward the haunted crisis route
- Chapter 5 is stable enough to reconnect earth-route fallout to Elinee, ruins, and coordinated corruption
- Chapter 6 is stable enough to widen the story into Upper Land, the Wind Sanctuary, and the first real sky-route political horizon
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
- the Godot folder scaffold, bootstrap rules, and initial `project.godot` shell are in place
- remaining open items are small enough that they do not block controller, dialogue, quest, and map framework work
