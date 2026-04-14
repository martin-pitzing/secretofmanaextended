param(
    [switch]$Headless,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$GodotArgs
)

$workspaceRoot = Split-Path -Parent $PSScriptRoot
$godotDir = Join-Path $PSScriptRoot "godot"
$projectPath = Join-Path $workspaceRoot "game"
$editorDataPath = Join-Path $godotDir "editor_data"
$tempPath = Join-Path $editorDataPath "temp"

if (-not (Test-Path $projectPath)) {
    throw "Expected Godot project at '$projectPath'."
}

if (-not (Test-Path $godotDir)) {
    throw "Expected local Godot binaries under '$godotDir'."
}

New-Item -ItemType Directory -Force -Path $editorDataPath, $tempPath | Out-Null

$env:APPDATA = $editorDataPath
$env:LOCALAPPDATA = $editorDataPath
$env:TEMP = $tempPath
$env:TMP = $tempPath

$consoleExe = Get-ChildItem $godotDir -Filter "*_console.exe" -File | Sort-Object Name | Select-Object -First 1
$guiExe = Get-ChildItem $godotDir -Filter "*.exe" -File | Where-Object { $_.Name -notlike "*_console.exe" } | Sort-Object Name | Select-Object -First 1
$godotExe = if ($consoleExe) { $consoleExe } else { $guiExe }

if (-not $godotExe) {
    throw "No Godot executable was found in '$godotDir'."
}

$launchArgs = @("--path", $projectPath)
if ($Headless) {
    $launchArgs += "--headless"
}
if ($GodotArgs) {
    $launchArgs += $GodotArgs
}

& $godotExe.FullName @launchArgs
exit $LASTEXITCODE
