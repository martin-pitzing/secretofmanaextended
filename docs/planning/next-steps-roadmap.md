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
- Chapter 9 is now drafted around the sandship, split-town occupation, and the route into the Lofty Mountains
- Chapter 10 is now drafted around Lofty Mountains scrutiny, the Moon Palace curated-grief archive, and the Tasnica high-pass handoff
- Wind Sanctuary and Fire Palace leadership are now named in the faction layer
- Tasnica's first concrete contact point is now locked to the reopened sky routes in Chapter 6
- Portrait Batch 01 is now locked
- the first Chapter 1 combat benchmark is now locked to the Forbidden Falls seal breach arena
- early reward variance and Pandora conservative-contact visibility are now defined
- the actual Godot project shell now exists under `game/`
- a playable prototype slice now exists with movement, dialogue, map switching, and the first Water Palace / Forbidden Falls graybox benchmarks
- a tracked PowerShell wrapper now launches Godot with workspace-scoped appdata for reliable CLI validation
- the prototype now reads Chapter 1-2 scene and quest YAML mirrors for benchmark labels, prompts, and runtime narrative text
- the prototype now executes a linear Chapter 1 scene sequence with active quest state and resulting flag updates sourced from the editorial mirrors

## Immediate Priority Order

### 1. Replace Debug Scene Advancement With Triggered Runtime State

Reason:

- the runtime slice now sequences Chapter 1, but completion still depends on manual debug input instead of world triggers, quest objectives, and persistence

## Pre-Programming Sequence After That

1. Continue narrative production with Chapter 11
2. Decide which graybox benchmark receives the first tile/blockout art pass
3. Mirror later stable chapters into deeper scene and quest YAML only when needed
4. Start the first persistence-aware controller, dialogue, and quest-state save pass

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
