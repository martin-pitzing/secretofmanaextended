# Randi Pose Crop Manifest Notes

This note explains how the current Randi pose-crop manifests should be used.

## Goal

Turn the imported reference pages into a repeatable transfer layer:

- `source page` remains high-resolution reference
- `crop rect` identifies the useful pose region
- `atlas cell` defines where the runtime-facing preview lands
- authored cleanup can later replace any crop without breaking slot order

## Current Target

Primary working profile:

- profile: `hero64_tall`
- cell size: `64x64`
- atlas size: `640x960`
- fit rule: `contain_bottom_center`
- padding: `4 px`

Comparison profile:

- profile: `native32_tall`
- cell size: `32x32`
- atlas size: `320x480`
- fit rule: `contain_bottom_center`
- padding: `2 px`

This is a gameplay-preview atlas, not the final cleaned hero sheet.

## Best Current Source Pages

- `randi_comprehensive_action_sheet`
  Best page for side locomotion, side jump, front defense, front hit, and first-pass front attack proxies.
- `randi_advanced_combat_sheet`
  Best page for stronger attack poses that preserve the original artwork quality.
- `randi_locomotion_sheet_a`
  Useful for ready-stance proxies when a front-facing idle is needed.

## Clip Status

### Strong Direct Transfer Candidates

- `attack_down`
- `walk_side`
- `run_side`
- `jump_side`
- `block_down`
- `hit_down`
- `attack_three_quarter`
- `advanced_combo`

These clips are already close enough to the original artwork that the preview atlas should resemble the source material well after scale-down.

### Proxy-Only Clips

- `idle_down`
- `idle_side`

These are currently placeholder transfers built from nearby stance or sway poses. They exist to reserve slot order and prove scale, not to define final animation quality.

## Known Gaps

- no clean imported `idle_up`
- no clean imported `walk_up`
- no clean imported `run_up`
- no clean imported `back-facing run`
- `attack_down` still needs in-between timing cleanup for final runtime animation

These should be solved with either:

1. a second crop pass from additional artwork pages, or
2. manual cleanup and redraw over the current transfer atlas

## Preview Builder

Use:

```powershell
.\tools\build-randi-pose-crop-preview.ps1 -EmitContactSheet
```

Outputs:

- `contact/randi_hero64_tall_pose_crop_preview.png`
- `contact/randi_hero64_tall_pose_crop_contact.png`

And for the comparison manifest:

```powershell
.\tools\convert-randi-pose-manifest-profile.ps1 -TargetProfile native32_tall
.\tools\build-randi-pose-crop-preview.ps1 -PoseManifestPath .\game\art\ch01\characters\randi\source_pages\manifests\randi_native32_tall_pose_crop_manifest.json -EmitContactSheet
```

Outputs:

- `contact/randi_native32_tall_pose_crop_preview.png`
- `contact/randi_native32_tall_pose_crop_contact.png`

## Review Standard

The preview is good enough for the next pass only if:

- Randi still reads as the original blond, hooded, compact sword hero
- the ear read stays subtle, not oversized
- cloak, satchel, gloves, and boot mass survive the downscale
- attack poses still feel committed and directional
- side locomotion keeps the brisk Mana/Alundra/Terranigma action read

If those fail, adjust crop rects first before doing heavier repaint work.
