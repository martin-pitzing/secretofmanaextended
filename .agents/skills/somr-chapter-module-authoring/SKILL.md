---
name: somr-chapter-module-authoring
description: Use when working on Secret of Mana Revisited chapter modules, scene or quest docs, YAML mirrors, validators, chapter handoffs, build profiles, or modular Godot refactors. Keeps Markdown authoritative, preserves stable IDs, and protects downstream chapter contracts.
---

# SOMR Chapter Module Authoring

Use this skill when the task touches story-safe chapter content, chapter-owned routing, validators, handoff logic, or modular build planning.

Read `references/source-map.md` first.

If the task changes progression, IDs, or chapter handoffs, also read `references/change-safety.md`.

## Workflow

1. Identify the ownership boundary.
   Decide whether the change belongs to the shared kernel or to a single chapter module.

2. Load only the relevant chapter sources.
   Read the matching `docs/chapters/*.md` file and the mirrored YAML files under `game/data/scenes/<chapter>/`, `game/data/quests/<chapter>/`, and `game/data/chapters/`.

3. Keep Markdown authoritative.
   Update the editorial doc first or in the same pass as the YAML mirror. Do not silently let the runtime mirrors become the new source of truth.

4. Preserve stable IDs.
   Keep IDs when prose changes but the gameplay contract does not. Create a new ID when the player goal, exit condition, required flags, or exported meaning changes.

5. Treat Chapter 1 as the kernel baseline.
   Chapter 1 is where combat feel, ring-command stub behavior, visual-profile rules, and validator patterns should be set before deeper Chapter 2-specific polish.

6. Prefer configuration over chapter-specific system overrides.
   Later chapters should extend shared systems by data, content, and configuration unless a real system gap is proven.

7. Protect handoffs and validation.
   If a change affects exported flags, scene order, quest order, or chapter boundaries, update or plan validator coverage explicitly.

8. Ask targeted questions when scope is unclear.
   Present 2-3 options with one recommendation whenever ambiguity affects architecture ownership, stable IDs, exported flags, or chapter boundaries.

## Output Checklist

- scene and quest IDs still follow `docs/content-conventions.md`
- scene roles use the vocabulary from `docs/action-rpg-terminology.md`
- Markdown and YAML mirrors agree
- chapter-owned flags are produced and consumed consistently
- Chapter 1 -> Chapter 2 handoff assumptions remain explicit
- build-profile or validator impact is called out
