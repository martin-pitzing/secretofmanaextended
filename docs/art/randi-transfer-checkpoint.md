# Randi Transfer Checkpoint

Date: `2026-04-27`

## What Exists Now

- imported Randi source pages are preserved under `game/art/ch01/characters/randi/source_pages/`
- the first reusable pose-crop transfer pipeline is live
- `hero64_tall` and `native32_tall` companion manifests now exist
- preview rebuild tooling exists and can regenerate both atlas previews on demand
- manifest-derived runtime frame export now writes directly into `game/art/ch01/characters/randi/hero/`
- `PlayerVisual` now uses the `hero64_tall` lane for `idle`, `walk`, `run`, directional attacks, jump clips, and hit preview fallback

## Locked Target

- `hero64_tall` is now the primary runtime-facing Randi atlas lane
- `native32_tall` remains a strict comparison lane so we can judge how much fidelity survives tighter atlas compression

## Primary Files

- `game/art/ch01/characters/randi/source_pages/manifests/randi_hero64_tall_pose_crop_manifest.json`
- `game/art/ch01/characters/randi/source_pages/manifests/randi_native32_tall_pose_crop_manifest.json`
- `game/art/ch01/characters/randi/source_pages/manifests/randi_pose_crop_manifest_notes.md`
- `tools/build-randi-pose-crop-preview.ps1`
- `tools/convert-randi-pose-manifest-profile.ps1`
- `tools/export-randi-hero-runtime-frames.ps1`

## Preview Outputs To Show

- `game/art/ch01/characters/randi/source_pages/contact/randi_hero64_tall_pose_crop_preview.png`
- `game/art/ch01/characters/randi/source_pages/contact/randi_hero64_tall_pose_crop_contact.png`
- `game/art/ch01/characters/randi/source_pages/contact/randi_native32_tall_pose_crop_preview.png`
- `game/art/ch01/characters/randi/source_pages/contact/randi_native32_tall_pose_crop_contact.png`

## Current Quality Gains

- side walk and run now use cleaner, more isolated source poses
- `idle_down` and `idle_side` now use cleaner turnaround-driven crops instead of the weakest placeholder bridge frames
- `attack_down` now uses direct sword-sway reference art instead of stance proxies
- `attack_side` and `attack_up` now exist as runtime clips with authored reference-driven in-betweens
- `idle_up`, `walk_down`, `walk_up`, `run_down`, and `run_up` no longer come from the old placeholder atlas
- `jump_down` and `jump_up` now export from the same `hero64_tall` manifest lane as the rest of the runtime set
- the `native32_tall` comparison path now makes it easy to judge whether the art survives a stricter in-game atlas size

## Known Remaining Gaps

- `idle_down` and `idle_side` are cleaner now but still need final authored cleanup rather than pure crop transfer
- `walk_down`, `walk_up`, `run_down`, and `run_up` are now sourced bridge loops, but still not final authored locomotion animation
- `attack_down`, `attack_side`, and `attack_up` are runtime-usable now, but still need final timing polish before production animation
- `jump_down`, `jump_side`, and `jump_up` are runtime-usable preview clips, but still need true authored jump motion rather than transferred bridge poses
- hit currently resolves through `hit_down` fallback only; side/up hit reactions are still missing

## Recommended Next Review Order

1. use `hero64_tall` as the active working atlas for the next runtime hook-up pass
2. compare against `native32_tall` only to judge fidelity loss, not to redefine the target
3. replace the bridge-quality `up` and `down` locomotion loops with authored `hero64_tall` equivalents
4. author cleaned `idle` and directional attack in-betweens on top of the current `hero64_tall` slot order
5. author side/up hit reactions and replace preview-stage jump bridges with final motion clips
