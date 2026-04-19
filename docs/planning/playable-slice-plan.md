# Secret of Mana Revisited: First Playable Slice Plan

## Goal

Turn the current Chapter 1-2 prototype into a stable internal vertical slice that can be launched, reviewed, and discussed without relying on hidden repo context.

## What Is Runnable Today

- the Godot project boots from `game/` and uses `scenes/main.tscn` as the playable entry scene
- the runtime currently wires only Chapters 1 and 2 into the campaign flow
- Chapter 1 and Chapter 2 scene and quest mirrors are loaded from the structured YAML under `game/data/`
- the current prototype already supports movement, interaction, dialogue, scene sequencing, quest progression, chapter handoff, and save/continue/restart flow
- the current playable benchmark spaces are Test Hall, Water Palace, Forbidden Falls, Pandora gate district, Pandora court route, and Pandora annex route
- Chapter 2 now validates end-to-end across gate, court, and annex routes through a dedicated headless playpass script
- the slice is still prototype-grade and uses drawn shapes, color blocking, and benchmark dressing rather than imported production art

## What Exists But Is Not Yet Playable

- Chapters 3-12 are drafted at the story and planning layer, but they are not yet loaded into the playable runtime
- there is not yet a full combat pass suitable for broader encounter design
- there is not yet a full party presentation layer beyond the current Chapter 2 prototype beats
- there is not yet a production-facing menu, inventory, export, or packaging pass
- the slice is still best understood as an internal review prototype rather than a player-facing demo

## What A First Playable Thing Should Mean

For this repo, the first real playable thing should be:

- bootable directly from the tracked Godot launcher
- understandable without needing debug-map knowledge
- completable from Chapter 1 through the end of Chapter 2
- readable enough that Primm's join, the court pursuit, and the ledger escape all land on first play
- stable enough that save/continue and chapter restarts are trustworthy during review
- documented enough that someone else can launch it, play it, and report on it without a guided walkthrough

## Execution Plan

### Phase 1. Stabilize The Existing Chapter 1-2 Route

- finish the locked Chapter 2 polish scope
- keep Chapter 1 and Chapter 2 on the current lightweight prototype systems instead of expanding into full combat, stealth, or party architecture
- add a repeatable smoke checklist for boot, chapter transition, save/continue, and Chapter 2 completion

Exit condition:

- the current route can be replayed cleanly from a new campaign and from a saved continuation without needing manual cleanup

### Phase 2. Improve Reviewability

- add a lightweight review path so Chapter 1 and Chapter 2 can be inspected quickly without relying on hidden debug-map keys
- make current objective, chapter, and completion state harder to misread in the HUD and chapter-transition flow
- tighten any remaining unclear trigger placement that causes players to wander or guess

Exit condition:

- an internal reviewer can reach the Chapter 2 material quickly and understand what the current build expects them to do

### Phase 3. Raise The Presentation Floor

- continue the reusable Pandora dressing pass so benchmark spaces read as authored places rather than placeholder geometry
- carry the same visual-language approach back across the Chapter 1 review-critical spaces where needed
- add only the minimum presentation beats needed to sell chapter progression and party-state changes

Exit condition:

- the slice reads as a coherent prototype with intentional visual direction instead of a raw benchmark harness

### Phase 4. Package An Internal Review Build

- document the launch path, controls, known limits, and expected chapter duration
- provide one internal review checklist covering first boot, fresh campaign, continue flow, Chapter 1 end, Chapter 2 end, and restart behavior
- decide whether the internal handoff is editor-only or whether a first export helper is worth the time

Exit condition:

- someone outside the immediate implementation loop can run the slice and give useful feedback with minimal setup help

## Task List By Ownership

| Task | Owner | Output |
| --- | --- | --- |
| Implement the Chapter 2 polish pass already scoped in `chapter-2-polish-scope.md` | Codex | clearer Primm join beat, clearer court pursuit lane, clearer ledger-target and exit read |
| Add a non-hidden review path for quickly seeing Chapter 1 and Chapter 2 | Codex | lightweight chapter review entry or equivalent reviewer-facing flow |
| Tighten HUD and progression clarity where the current slice still depends on prior knowledge | Codex | easier first-play readability and fewer false stalls |
| Keep building reusable Pandora dressing primitives and apply them where Chapter 1-2 still feels too abstract | Codex | stronger benchmark presentation without locking into final art too early |
| Approve the desired review target for the first internal slice | Shared | clear agreement on whether the slice ends at Chapter 2 departure or expands further |
| Call out any chapter moments that must read emotionally before broader system work continues | User | prioritised creative feedback for the next polish pass |
| Decide whether the first playable thing is editor-reviewed only or should be packaged for wider sharing | Shared | right-sized release target for the next milestone |
| Prepare launch instructions, a smoke checklist, and a review handoff note | Codex | repeatable internal review package |

## Immediate Recommended Order

1. Implement the first Chapter 2 polish pass.
2. Add a reviewer-friendly way to inspect Chapter 1 and Chapter 2 without relying on debug shortcuts.
3. Lock the review checklist and acceptance criteria for the first playable slice.
4. Package the current Chapter 1-2 route as the first internal playable thing.
