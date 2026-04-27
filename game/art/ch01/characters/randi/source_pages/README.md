# Randi Source Pages

This folder is the ingest target for the structured artwork pages in `pictures_artworks/`.

Pipeline usage:

```powershell
.\tools\import-pictures-artworks.ps1
```

Expected outputs:

- `svg_master/`
- `png_master/`
- `contact/`
- `templates/`
- `manifests/`

Pose crop preview usage:

```powershell
.\tools\build-randi-pose-crop-preview.ps1 -EmitContactSheet
```

Relevant files:

- `manifests/randi_hero64_tall_pose_crop_manifest.json`
- `manifests/randi_native32_tall_pose_crop_manifest.json`
- `manifests/randi_pose_crop_manifest_notes.md`
- `contact/randi_hero64_tall_pose_crop_preview.png`
- `contact/randi_hero64_tall_pose_crop_contact.png`
- `contact/randi_native32_tall_pose_crop_preview.png`
- `contact/randi_native32_tall_pose_crop_contact.png`

Important:

- these are `source and reference pages`
- they are not final runtime atlases
- they should drive atlas authoring, not replace it automatically
