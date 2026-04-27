# Randi Transfer Checkpoint

Date: `2026-04-27`

## What Exists Now

- imported Randi source pages are preserved under `game/art/ch01/characters/randi/source_pages/`
- the first reusable pose-crop transfer pipeline is live
- `hero64_tall` and `native32_tall` companion manifests now exist
- preview rebuild tooling exists and can regenerate both atlas previews on demand

## Primary Files

- `game/art/ch01/characters/randi/source_pages/manifests/randi_hero64_tall_pose_crop_manifest.json`
- `game/art/ch01/characters/randi/source_pages/manifests/randi_native32_tall_pose_crop_manifest.json`
- `game/art/ch01/characters/randi/source_pages/manifests/randi_pose_crop_manifest_notes.md`
- `tools/build-randi-pose-crop-preview.ps1`
- `tools/convert-randi-pose-manifest-profile.ps1`

## Preview Outputs To Show

- `game/art/ch01/characters/randi/source_pages/contact/randi_hero64_tall_pose_crop_preview.png`
- `game/art/ch01/characters/randi/source_pages/contact/randi_hero64_tall_pose_crop_contact.png`
- `game/art/ch01/characters/randi/source_pages/contact/randi_native32_tall_pose_crop_preview.png`
- `game/art/ch01/characters/randi/source_pages/contact/randi_native32_tall_pose_crop_contact.png`

## Current Quality Gains

- side walk and run now use cleaner, more isolated source poses
- `attack_down` now uses direct sword-sway reference art instead of stance proxies
- the `native32_tall` comparison path now makes it easy to judge whether the art survives a stricter in-game atlas size

## Known Remaining Gaps

- `idle_down` and `idle_side` still need final authored cleanup rather than pure crop transfer
- `up-facing` locomotion is still not covered by the imported source pages
- `attack_down` still needs final timing/in-between cleanup before runtime animation work
- no runtime clip hookup has been done yet; this is still source-to-atlas preparation work

## Recommended Next Review Order

1. compare `hero64_tall` and `native32_tall` previews side by side
2. decide whether runtime should stay on `hero64_tall` first or force a stricter `native32_tall` lane
3. author cleaned `idle` and `attack_down` final frames on top of the current slot order
4. start wiring the first real hero atlas clips into the player visual runtime
