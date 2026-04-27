# Pictures Artworks Transfer Pipeline

## Purpose

Create a repeatable pipeline that transfers the artwork pages in `pictures_artworks/` into the repo as preserved masters, clean raster references, atlas templates, and import manifests.

This pipeline exists because the source files are not direct game atlases.
They are structured `reference artwork pages`.

## Core Rule

Do not collapse these into one resolution concept.

There are at least three different layers:

- `source master`
  - the original SVG artwork page
- `reference raster`
  - a clean rendered PNG of that page
- `game atlas logic`
  - the cell-based atlas size the runtime eventually uses

If these are mixed together, the project starts making bad art decisions and bad runtime decisions at the same time.

## Current Source Reality

The current files in `pictures_artworks/` are SVG masters.

They are:

- hero reference pages
- locomotion and combat reference sheets
- not direct runtime sprite atlases

That means the pipeline should:

1. preserve the SVGs untouched
2. rasterize them cleanly into PNG reference pages
3. classify them by subject and clip-group purpose
4. generate blank atlas templates for the real game targets
5. let art or paintover work transfer the poses into actual runtime atlases

## Resolution Model

Treat these as separate values:

- `master_page_vector_size`
  - from the SVG file itself
- `reference_render_size`
  - the PNG output size we render for review and crop work
- `logical_cell_size`
  - `32x32` if using native legacy atlas logic
- `native_atlas_size`
  - for example `320x320` or `320x480`
- `hero_runtime_atlas_size`
  - for example `640x640` or `640x960` if we keep the current higher-fidelity hero runtime path

The important point is:

- the source page is not the runtime atlas
- the source page only feeds the runtime atlas

## Current Project Recommendation

Use a dual-output transfer model:

- `native32`
  - keeps the original `32x32` cell logic available
- `hero64`
  - supports the current gameplay-facing runtime while we are still building the Randi hero controller

This avoids locking the project into one guess too early.

## Folder Outputs

The transfer pipeline writes to:

- `game/art/ch01/characters/randi/source_pages/svg_master/`
- `game/art/ch01/characters/randi/source_pages/png_master/`
- `game/art/ch01/characters/randi/source_pages/contact/`
- `game/art/ch01/characters/randi/source_pages/templates/`
- `game/art/ch01/characters/randi/source_pages/manifests/`

## What The Script Does

`tools/import-pictures-artworks.ps1` does the following:

1. reads `pictures_artworks/pipeline_manifest.json`
2. copies the SVG masters into the runtime-adjacent art tree
3. rasterizes each SVG page through headless Chrome into a clean PNG reference page
4. records page metadata and clip-group intent into a normalized manifest
5. builds a contact sheet of the rasterized pages
6. creates blank grid templates for:
   - `native32`
   - `native32_tall`
   - `hero64`
   - `hero64_tall`

## What The Script Does Not Do

It does not:

- magically convert painted artwork into final pixel sprites
- choose final feet pivots for every gameplay clip
- replace manual atlas authoring
- create final attack timing data

That work still happens after ingest.

## Recommended Next Production Step After Ingest

After the pages are imported, do this:

1. choose one page as the primary locomotion reference
2. crop or trace the exact poses needed for:
   - idle
   - walk
   - run
   - jump
   - attack
   - hit
3. transfer those poses into either:
   - `native32_tall`
   - or `hero64_tall`
4. only then wire the runtime atlas to those authored frames

## Current Reading Of The Folder

The current folder looks hero-focused, not monster-focused.
So the pipeline is generic, but the first configured subject is `Randi`.
