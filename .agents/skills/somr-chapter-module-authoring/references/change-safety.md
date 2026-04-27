# Story-Safe Change Rules

Use this checklist when a request could change progression, IDs, or downstream assumptions.

## Stable-ID Rule

- Preserve IDs when flavor or prose changes but the gameplay contract stays intact.
- Create a new ID when any of these change materially:
  - player goal
  - required prior flags
  - exit condition
  - resulting exported flag meaning

## Semantic Shift Declaration

When you must change meaning without a clean rename, add a short declaration in the relevant planning note or change summary:

- old meaning
- new meaning
- affected chapters
- validator impact

## Dependency Rule

Scenes and quests should move toward explicit declarations for:

- required prior flags
- blocked flags
- optional flavor flags
- resulting flags

## Handoff Rule

Treat Chapter 1 -> Chapter 2 validation as a hard dependency before enabling Chapter 3 runtime content.

## Modular Ownership Rule

- mainline story progression remains the priority
- side objectives stay chapter-owned for now
- later chapters may consume exported flags from earlier chapters, but must not redefine them
