# Secret of Mana Revisited: Preproduction Task Tracker

## Status Key

- `done`: completed in current preproduction pass
- `next`: should be tackled immediately after this pass
- `open`: unresolved but known
- `later`: intentionally deferred until programming or later chapter work

## Core Preproduction Tasks

| Task | Status | Notes |
| --- | --- | --- |
| Story modules drafted | done | modular story arc exists |
| Art direction brief drafted | done | visual lane and benchmark direction locked |
| Development framework drafted | done | Godot and pipeline direction established |
| Faction bible drafted | done | base faction logic exists |
| Faction leadership named | done | major leaders and officers added |
| Pandora character sheets | done | key court figures and Dyluck defined |
| Empire character sheets | done | key bloc representatives defined |
| Chapter 1 package | done | scene list, quest flow, world-state outputs, art needs |
| Chapter 2 package | done | Pandora political crisis and first direct imperial pressure defined |
| Chapter 3 package | done | Gaia's Navel, Watts, Popoi, and Earth Vault pressure defined |
| Chapter 4 package | done | Earth Seed restoration, Popoi memory bleed, and first sword restoration pass defined |
| Chapter 5 package | done | Elinee, haunted ruins, and first unmistakable coordinated corruption arc defined |
| Chapter 6 package | done | Upper Land expansion, Wind Sanctuary memory-tithe arc, and first Tasnica correspondence defined |
| Chapter 7 package | done | Fire borderland route, false-map secrecy, and Fire Seed restoration defined |
| Chapter 8 package | done | Kakkara occupation corridor, aquifer diversion, and sandship manifest handoff defined |
| Chapter 9 package | done | Sandship transport network, split-town occupation, and mountain-route charter defined |
| Chapter 10 package | done | Lofty Mountains scrutiny system, Moon Palace curated-grief arc, and Tasnica high-pass handoff defined |
| Chapter 11 package | done | Tasnica alliance politics, Jema treaty fallout, and Light Palace legitimacy dispute defined |
| Chapter 12 package | done | Light Palace legitimacy war, corrected-record exposure, and Dark Palace route handoff defined |
| Story and setting expansion pass | done | classic Mana-series motifs integrated into the setting direction |
| Temple turn matrix | done | temples now have layered twists and regional consequences |
| Core cast sheets | done | Randi, Primm, Popoi, Luka, Jema, and Thanatos aligned to the new mythology |
| Temple dossiers | done | eight production-facing dossiers created |
| World texture pass | done | peripheral cultures, relics, and non-state texture defined |
| Magic doctrine and weapon schools | done | shared language for magic before systems implementation |
| Dyluck mission brief | done | political and operational truth of his disappearance now defined |
| First temple authority dispute scene | done | Luka vs Falls shrine conflict now dramatized on-screen |
| Subculture briefs | done | world texture converted into scene-ready groups |
| Visual production decisions | done | first benchmark environment and portrait format are locked |
| Chapter 1 environment production kits | done | Potos, Forbidden Falls, and Water Palace kits now define material, prop, dressing, and Godot-first benchmark priorities |
| Water Palace benchmark checklist | done | first environment benchmark is now execution-ready |
| Portrait Batch 01 locked | done | first real portrait production scope and expression tiers are fixed |
| Chapter 1 combat benchmark locked | done | Forbidden Falls seal breach arena chosen as the first combat reference room |
| Early progression locks | done | reward variance and Pandora conservative-contact visibility are now defined |
| Mirrored `game/data/` starter files | done | Chapters 1-3 and core cast/faction manifests now have YAML starter shells |
| Expanded mirrored `game/data/` manifests | done | Chapters 4-6 plus characters, regions, temples, and flag manifests added |
| First scene- and quest-level structured mirrors | done | Chapters 1-2 now have per-scene and per-quest YAML mirrors |
| Content conventions and IDs | done | naming rules and implementation-readiness rules defined |
| Content templates | done | reusable templates added |
| Godot bootstrap rules | done | pre-coding scaffold rules defined |
| Folder scaffold created | done | repo structure established without gameplay code |
| Godot project shell created | done | `game/` now contains `project.godot`, entry scene, and project hygiene files |
| Godot local runner wrapper | done | workspace-scoped launcher now supports editor use and headless checks |
| First controller, dialogue, and map prototype pass | done | playable runtime slice now exists with movement, interaction, and map switching |
| First playable benchmark spaces | done | Water Palace and Forbidden Falls graybox spaces are now live in-engine |
| First data-driven runtime loading pass | done | current prototype now reads Chapter 1-2 scene and quest mirrors for benchmark metadata |
| First Chapter 1 scene sequencing and quest-state runtime pass | done | prototype now advances through Chapter 1 scene order, active quests, and resulting flags |
| First Chapter 1 trigger-based persistence pass | done | Chapter 1 now advances through in-world scene gates and restores saved runtime state |
| First Chapter 2 trigger-based runtime pass | done | campaign now hands off from Chapter 1 into Chapter 2 and uses a dedicated Pandora benchmark map |

## Immediate Follow-Up Tasks

| Task | Status | Notes |
| --- | --- | --- |
| Replace Chapter 2 staging-room fallbacks with more dedicated Pandora and court-route grayboxes | done | Chapter 2 now routes across dedicated gate-district, court-route, and annex/lower-gate benchmarks instead of one civic-knot map |
| Start the first Pandora art and blockout pass | done | gate district, court route, and annex/lower-gate route now share a stronger Pandora visual lane and more district-specific blockout reads |
| Tighten campaign save and continue flow | done | startup flow now has visible continue/restart actions, chapter handoff uses a chapter card, and campaign checkpoints persist map context alongside chapter state |
| Run a full Chapter 2 route validation pass | done | a headless Chapter 2 playpass check now validates map assignment, trigger placement, spawn sanity, quest completion order, and final flags across all 8 scenes |
| Continue narrative production with Chapter 13 | open | the Light Palace route now points directly into the Dark Palace and the most openly dangerous sacred compromises |
| Decide Chapter 2 party and combat polish scope | done | scope is now locked to Primm join presentation, court-route pursuit readability, and ledger-target clarity without adding full stealth or party systems; see `docs/planning/chapter-2-polish-scope.md` |
| Implement the first Chapter 2 polish pass | next | apply the locked polish scope to the safehouse alliance beat, court pursuit route, and ledger recovery pressure |
| Lock the first playable slice definition | done | current runnable scope, limits, and milestone order are now captured in `docs/planning/playable-slice-plan.md` |
| Add a reviewer-friendly Chapter 1-2 access path | open | make it possible to inspect the current slice quickly without relying on hidden debug-map knowledge |
| Package the Chapter 1-2 route as an internal playable thing | open | document launch, controls, smoke checks, and review expectations for the first real handoff |

## Open Pre-Programming Items

| Item | Status | Notes |
| --- | --- | --- |
| No blocking items remain | done | remaining questions are later-story or implementation-sequencing choices rather than preproduction blockers |

## Deferred Until Programming

| Task | Status | Notes |
| --- | --- | --- |
| Build dialogue system | later | blocked until implementation phase |
| Build quest system | later | blocked until implementation phase |
| Implement map and controller framework | later | blocked until implementation phase |
| Deepen mirrored data into runtime-ready JSON or YAML | later | only after editorial docs stop shifting |
