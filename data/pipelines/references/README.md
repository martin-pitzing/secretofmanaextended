# Canon reference materials

Per-creature source artwork that defines what a monster *is* — silhouette, body
plan, recognizable beats. Manifests under `data/pipelines/monsters/` point at
these files via the `canon_references` field; the plan builder picks the
`role: primary` entry as the `style_image` fed to Ludo.

The biome anchor (e.g. `forbidden_falls_anchor.yaml`) is a separate concern —
it shapes palette and lighting, not silhouette. Style adaptation notes in the
manifest describe what changes between canon and our chapter version.

## Layout

    data/pipelines/references/
      monsters/
        {biome}/
          {monster_id}/
            {name}.png        # canonical sprite, cleanly cropped
            {name}_side.png   # additional angles where useful
            sources.md        # provenance notes (URL, license)

## Sourcing

Acceptable canon sources for the SoM '93 bestiary:

- https://wikiofmana.com — community wiki, generally has clean sprite rips
- Internal screenshots / sprite extracts you control

Prefer cleanly-cropped, transparent-background PNGs. If the wiki only offers
inline images on a page (not direct URLs), download manually and drop them
here. URLs in manifests work too if the source is stable — but local copies
are reproducible across reruns.

## Format note (important)

The Ludo `generateWithStyle` endpoint rejects PNGs that carry an alpha channel
or ICC profile metadata with `400 Invalid image data`. Before we send a canon
reference as `style_image`, the pipeline transcodes it through Pillow to
**JPEG, RGB, no metadata, max edge 256px**. The transparent-background PNG
on disk is still the source of truth — the JPEG is generated on the fly.

## Licensing

These are reference assets used to ground generation, not redistributed
sprites. Keep `sources.md` per creature so we can audit later.
