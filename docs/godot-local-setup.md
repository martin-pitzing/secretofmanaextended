# Local Godot Setup

## Goal

Open this workspace's Godot shell locally on Windows and confirm the tracked project under `game/` launches cleanly.

## Target Version

- install `Godot 4.4+`
- use the standard editor build
- C# is not required for this project right now

## Install On Windows

1. Download the current Windows editor from [godotengine.org](https://godotengine.org/download/windows/).
2. Choose the standard `Win64` editor build.
3. Unzip it somewhere stable, for example:
   - `C:\Tools\Godot\`
4. Optional:
   Add that folder to your `PATH` if you want to launch Godot from PowerShell later.

## Open This Project

1. Start Godot.
2. In the Project Manager, choose `Import`.
3. Select:
   [project.godot](C:/Dev/secretofmana-extended/game/project.godot)
4. Confirm the project name is `Secret of Mana Revisited`.
5. Open the project.

## What You Should See

- the project root is `C:\Dev\secretofmana-extended\game`
- the prototype startup scene is:
  [main.tscn](C:/Dev/secretofmana-extended/game/scenes/main.tscn)
- running the project should now open the prototype runtime with:
  - a playable `Prototype Test Hall`
  - map switching to `Water Palace Inner Chamber` and `Forbidden Falls Seal Breach`
  - a top-left HUD showing the active benchmark and controls

## Expected First-Run Behavior

- Godot will create local editor metadata under:
  - `C:\Dev\secretofmana-extended\game\.godot\`
- that folder is already ignored in Git
- the project is still graybox-heavy, so most visuals are drawn primitives rather than imported assets

## Recommended Editor Checks

After opening the project, verify:

1. `Project > Project Settings > Display`
   - viewport width is `480`
   - viewport height is `270`
2. `Stretch Mode`
   - `viewport`
3. `Stretch Aspect`
   - `keep`
4. `Scale Mode`
   - `integer`

These are already set in:
[project.godot](C:/Dev/secretofmana-extended/game/project.godot)

## Recommended Next Editor Actions

1. Set your filesystem dock favorites to:
   - `scenes/`
   - `scripts/`
   - `systems/`
   - `data/`
   - `art/`
   - `ui/`
2. Save the imported project in Godot's project list.
3. Use `1`, `2`, `3`, or `Tab` in play mode to move between the active prototype spaces.
4. Do not reorganize the folder structure from inside the editor unless we explicitly decide to.

## Optional PowerShell Launch

If you add Godot to `PATH`, you can launch the editor from the repo root with:

```powershell
godot --path C:\Dev\secretofmana-extended\game
```

If you do not add it to `PATH`, run the executable directly, for example:

```powershell
& "C:\Tools\Godot\Godot_v4.4.1-stable_win64.exe" --path C:\Dev\secretofmana-extended\game
```

If you place the local binaries under:

- `C:\Dev\secretofmana-extended\tools\godot\`

you can use the tracked wrapper from the repo root instead:

```powershell
.\tools\run-godot.ps1
```

For headless validation:

```powershell
.\tools\run-godot.ps1 -Headless -- --quit
```

## Current Scope Reminder

This project is ready for:

- opening the shell
- scene inspection
- controller, dialogue, and graybox map prototyping
- first-pass benchmark iteration

It does **not** yet contain:

- quest runtime
- imported production art
