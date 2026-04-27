# Secret of Mana Revisited: Open Items Register

## Locked Defaults

- Tone balance: melancholic mythic adventure with political weight
- Chapter 1 endpoint: Pandora arrival and first political contact
- Route structure: one canonical route with optional flavor branches that preserve the same result
- Popoi in Chapter 1: foreshadowing only
- First imperial presence in Chapter 1: indirect, with Magistrate Severin Kroll as the default named pressure source
- First direct imperial on-screen appearance: `Chapter 2`, via `Kroll's Offer`
- Broader Mana-series peoples and cultures: use as light setting influence unless a specific lineage is made plot-central
- Dyluck's disappearance: politically split mission with public relief cover and hidden investigative purpose
- First explicit temple authority dispute: Water Palace vs Falls Shrine line, led by Luka and Sister Yselle
- Popoi's full introduction point: `Chapter 3`, in Gaia's Navel and the lower ruin sequence
- First benchmark environment: `Water Palace inner chamber`
- Project gameplay lane terminology: `2D Mana-lineage action RPG` with `Secret of Mana`, `Alundra`, and `Terranigma` as the primary reference stack
- Dialogue portrait format: `96x96` detailed pixel portrait panels
- Water Palace benchmark checklist: defined and ready for production use
- First scene and quest YAML mirrors: Chapters 1-2 complete
- Thanatos early manifestation style: recurring false-comfort imagery, grief-lure scenes, and matched corruption residue should make his method legible before he is named directly
- Additional early temple leadership named: Waykeeper Ilyra Sen for the Wind Sanctuary and Furnace Warden Maelis Brann for the Fire Palace
- Tasnica visibility rule: rumor only in Chapters 1-2, first concrete correspondence in `Chapter 6` through reopened sky routes
- Portrait Batch 01 locked: see `docs/art/portrait-batch-01-spec.md`
- Chapter 1 secondary combat benchmark locked: `Forbidden Falls seal breach arena`
- Early reward variance rule: mainline remains narrative-first in Chapters 1-2, with only light optional equipment variance
- Pandora conservative / imperial contact rule: indirect, proxy-led, and document-driven in Chapters 1-2
- Chapter packaging rule: `one module per chapter`
- Runtime source-of-truth rule: Markdown stays authoritative and YAML remains the runtime mirror
- Story safety rule: validators plus explicit dependency declarations are the default target
- Chapter override rule: later chapters should extend shared systems through configuration and content, not bespoke system overrides, unless a real kernel gap is proved
- Chapter 1 baseline rule: Chapter 1 defines the first shared combat-feel and ring-command-stub baseline before deeper Chapter 2 polish
- Build-target rule: support `dev_all_content`, `review_slice_ch01`, and `review_slice_ch01_ch02`
- Review-build debug rule: debug access stays behind a dev toggle
- Visual module rule: reusable chapter visual profiles come before scene-specific exceptions
- Story-ID rule: preserve IDs whenever possible and add semantic-shift declarations when meaning changes
- Cross-chapter side-content rule: side objectives stay chapter-owned for now
- Placeholder stills rule: still boards remain part of the modular chapter pipeline
- Chapter handoff rule: Chapter 1 -> Chapter 2 validation is mandatory before Chapter 3 becomes runtime content

## Open Items That Still Matter Before Programming

No unresolved pre-programming blockers remain.

Any remaining questions are later-story or implementation-sequencing questions, not foundation blockers.

Current default:

- Markdown remains the editorial source of truth
- YAML starter shells are now allowed for stable chapter, scene, quest, and manifest-level content under `game/data/`
