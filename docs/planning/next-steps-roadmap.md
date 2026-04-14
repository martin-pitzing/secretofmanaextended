# Secret of Mana Revisited: Next Steps Roadmap

## Goal

Move from broad preproduction into a tighter narrative production sequence without starting gameplay systems too early.

## What Changed In This Pass

- classic Mana-series motifs were added to deepen the world
- temple arcs were upgraded from progression nodes to layered sacred questlines
- the project now has a clearer mythic identity beyond the original *Secret of Mana* pacing
- Chapters 1 and 2 now have structured scene and quest mirrors under `game/data/`
- Chapter 6 is now drafted around the Upper Land and Wind Sanctuary arc
- Chapter 7 is now drafted around the Fire Palace borderland and false-map catastrophe arc
- Chapter 8 is now drafted around Kakkara's occupation corridor, aquifer diversion, and the sandship manifest handoff
- Wind Sanctuary and Fire Palace leadership are now named in the faction layer
- Tasnica's first concrete contact point is now locked to the reopened sky routes in Chapter 6
- Portrait Batch 01 is now locked
- the first Chapter 1 combat benchmark is now locked to the Forbidden Falls seal breach arena
- early reward variance and Pandora conservative-contact visibility are now defined
- the actual Godot project shell now exists under `game/`
- a playable prototype slice now exists with movement, dialogue, map switching, and the first Water Palace / Forbidden Falls graybox benchmarks
- a tracked PowerShell wrapper now launches Godot with workspace-scoped appdata for reliable CLI validation

## Immediate Priority Order

### 1. Turn The Prototype Slice Into Data-Driven Runtime Loading

Reason:

- the runtime slice now works, so the next useful step is to replace hardcoded scene flow with structured content loading wherever the editorial docs are already stable

## Pre-Programming Sequence After That

1. Continue narrative production with Chapter 9
2. Build the first dialogue and scene loader pass against the existing Chapter 1-2 YAML mirrors
3. Decide which graybox benchmark receives the first tile/blockout art pass
4. Mirror later stable chapters into deeper scene and quest YAML only when needed

## Open Decisions That Still Matter

- how directly to import broader Mana-series peoples versus keeping them as lighter setting influence
- whether Popoi's people become a major late-game reveal or a distributed mystery
- exact timing of when later overt Pandora conservative-imperial coordination becomes public

## Recommended Creative Guardrails

- keep the emotional spine of *Secret of Mana*
- deepen the world without overcrowding it
- use classic Mana motifs as resonance, not franchise clutter
- let temples reveal moral compromises, not only lore
- keep each major revelation tied to character pain, not only ancient history
