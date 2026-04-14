# Secret of Mana Revisited: Content Conventions

## Purpose

These conventions prevent a later reorganization when narrative docs begin mirroring into implementation data.

## ID Rules

### Chapters

Format: `ch##_short-name`

Examples:

- `ch01_falls_to_pandora`
- `ch02_beneath_the_mountain`

### Scenes

Format: `ch##_sc##_short-name`

Examples:

- `ch01_sc01_potos_morning`
- `ch01_sc04_exile_procession`

### Quests

Format: `q_ch##_###_short-name`

Examples:

- `q_ch01_001_leave_potos`
- `q_ch01_003_seek_water_palace`

### Flags

Format: `flag_domain_subject_state`

Recommended domains:

- `chapter`
- `faction`
- `character`
- `temple`
- `region`
- `quest`

Examples:

- `flag_chapter_ch01_started`
- `flag_region_potos_panic`
- `flag_character_randi_exiled`
- `flag_faction_water_palace_trust_low`

### Factions

Format: `fac_short-name`

Examples:

- `fac_pandora_court`
- `fac_water_palace_order`
- `fac_empire_expansion_command`

### Characters

Format: `char_short-name`

Examples:

- `char_randi`
- `char_primm`
- `char_dyluck`

### Regions

Format: `reg_short-name`

Examples:

- `reg_potos`
- `reg_water_palace`
- `reg_pandora`

## Required Metadata By Content Type

### Faction Sheet

- ID
- faction name
- role
- doctrine
- leadership
- public face
- hidden agenda
- conflict hooks
- chapter relevance

### Character Sheet

- ID
- role
- faction ties
- public persona
- internal motive
- fear
- contradiction
- relationship map
- act function
- visual direction

### Scene Spec

- scene ID
- chapter ID
- location
- participants
- trigger
- player goal
- narrative beat
- gameplay beat
- exit condition
- resulting flags

### Quest Spec

- quest ID
- chapter ID
- unlock condition
- objectives
- optional branches
- fail or soft-lock conditions
- rewards
- resulting flags

## Data Representation Policy

During preproduction:

- write design and narrative content in Markdown
- keep one document per major unit when possible
- favor human-readable prose with explicit IDs attached

When implementation begins:

- mirror stabilized content into JSON or YAML under `game/data/`
- preserve IDs exactly
- keep Markdown docs as the editorial source of intent

## Acceptance Standard For Implementation-Ready Writing

Writing is implementation-ready when:

- an engineer can build the scene or quest without guessing the player objective
- a designer can derive required map interactions from the spec
- an artist can identify the required character, environment, and prop outputs
- a writer can extend adjacent scenes without renaming IDs or reinterpreting the core conflict
- every scene produces explicit state changes or confirms none occur
