# Chapter 1 Sightline Pass

## Purpose

Make all Chapter 1 scenes visible in-engine before final environment art is ready.

The goal is not to finish every Chapter 1 location as a full benchmark map. The goal is to ensure the complete chapter can be seen, staged, and reviewed as a continuous visual route inside Godot.

## Why This Pass Exists

Chapter 1 already had strong benchmark coverage for:

- `ch01_sc02_forbidden_falls`
- `ch01_sc06_luka_charge`
- `ch01_sc08_pandora_gate_district`

But the remaining scenes risked collapsing into one generic fallback space. That made the chapter readable as data and progression, but not as a visual arc.

This pass fixes that by giving every Chapter 1 scene one of three representations:

- `full benchmark map`
- `walkable story stage`
- `static still board`, only if a story stage is not yet worth building

## Representation Rules

### Full Benchmark Map

Use when the scene needs:

- combat readability
- more than one interaction cluster
- environmental navigation
- a composition strong enough to become a reference room for later production

### Walkable Story Stage

Use when the scene mainly needs:

- one clear place identity
- one short route through the scene
- two to four interaction points
- one completion trigger that advances the chapter cleanly

### Static Still Board

Use only when:

- the scene is too early to justify a map pass
- the visual need is primarily review, not interaction
- the artwork exists as concept or placeholder stills but not yet as spatial dressing

If a static still board is used, it should still sit inside a walkable scene shell with one short route and one trigger, not a menu-only viewer.

## Chapter 1 Scene Mapping

| Scene ID | Scene Title | Representation | Current Runtime Target |
| --- | --- | --- | --- |
| `ch01_sc01_potos_morning` | Potos Morning | walkable story stage | `potos_story_stage` |
| `ch01_sc02_forbidden_falls` | The Forbidden Falls | full benchmark map | `forbidden_falls_benchmark` |
| `ch01_sc03_judgment_at_potos` | Judgment At Potos | walkable story stage | `potos_story_stage` with judgment variant |
| `ch01_sc04_exile_procession` | Exile Road | walkable story stage | `exile_road_stage` |
| `ch01_sc05_water_palace_approach` | Water Palace Approach | walkable story stage | `water_palace_approach_stage` |
| `ch01_sc06_luka_charge` | Luka's Charge | full benchmark map | `water_palace_benchmark` |
| `ch01_sc07_road_to_pandora` | Road To Pandora | walkable story stage | `road_to_pandora_stage` |
| `ch01_sc08_pandora_gate_district` | Pandora At The Edge | full benchmark map | `pandora_district_benchmark` |

## Visual Arc Requirement

The player should be able to read the entire Chapter 1 route in this order:

1. home and routine in Potos
2. sacred danger at the falls
3. public rupture in the village
4. abandonment on the exile road
5. institutional calm at the Water Palace approach
6. sacred authority in Luka's chamber
7. regional strain on the road to Pandora
8. civic pressure at Pandora's edge

If two neighboring scenes feel visually interchangeable, the pass is not done.

## Godot Layout Rules

### Scene Shell Rules

Every walkable story stage should provide:

- one scene-specific map title
- one short traversable path
- two to four interaction triggers
- one completion trigger
- one distinct palette and prop language tied to the story beat

### Prototype Economy Rules

- reuse the existing `PrototypeMap` framework
- prefer simple geometry, color blocking, and prop silhouettes over premature production art
- do not let Chapter 1 scenes fall back to the generic `test_room` once a stage exists
- keep benchmark-grade detail focused on `Forbidden Falls`, `Water Palace inner chamber`, and `Pandora gate district`

### Still-Board Rules

When still artwork becomes available, mount it into the runtime as scene-local placeholder art, not as a separate tool.

Recommended shell:

- one backdrop still or matte board
- one foreground path
- one prop cluster layer
- one conversation pocket
- one completion marker

## Placeholder Art Folder Layout

Use this folder structure when still boards or rough scene paintings start landing:

```text
game/art/ch01/review_stills/
  ch01_sc01_potos_morning/
  ch01_sc03_judgment_at_potos/
  ch01_sc04_exile_procession/
  ch01_sc05_water_palace_approach/
  ch01_sc07_road_to_pandora/
```

Recommended naming inside each scene folder:

- `backdrop_v01.png`
- `backdrop_v02.png`
- `notes.md`
- `crop_reference.png`

## Original-Material Anchor Rules

Use the original *Secret of Mana* material as the anchor for:

- immediate silhouette read
- mood and pacing
- location hierarchy
- emotional clarity

Use the revisit's own docs to add:

- ritual wear
- social function
- archive logic
- route pressure
- signs of institutional strain

The result should feel recognizable as Mana first, and more detailed second.

## Acceptance Criteria

This pass is done when:

- every Chapter 1 scene resolves to a distinct visible place in-engine
- no Chapter 1 story scene routes through the generic `test_room`
- the chapter can be walked from start to Pandora with a readable visual arc
- placeholder stages are good enough to discuss composition, staging, and chapter rhythm without needing final art
