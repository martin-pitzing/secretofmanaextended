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
- the placeholder startup scene is:
  [main.tscn](C:/Dev/secretofmana-extended/game/scenes/main.tscn)
- running the project should show a simple placeholder screen with:
  - `Secret of Mana Revisited`
  - `Godot shell placeholder scene`

## Expected First-Run Behavior

- Godot will create local editor metadata under:
  - `C:\Dev\secretofmana-extended\game\.godot\`
- that folder is already ignored in Git
- no production assets or gameplay systems exist yet, so the project should open quickly

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
3. Do not reorganize the folder structure from inside the editor unless we explicitly decide to.

## Optional PowerShell Launch

If you add Godot to `PATH`, you can launch the editor from the repo root with:

```powershell
godot --path C:\Dev\secretofmana-extended\game
```

If you do not add it to `PATH`, run the executable directly, for example:

```powershell
& "C:\Tools\Godot\Godot_v4.4.1-stable_win64.exe" --path C:\Dev\secretofmana-extended\game
```

## Current Scope Reminder

This project is ready for:

- opening the shell
- scene inspection
- early scene/system prototyping

It does **not** yet contain:

- controller logic
- dialogue runtime
- quest runtime
- real game maps
- imported production art
