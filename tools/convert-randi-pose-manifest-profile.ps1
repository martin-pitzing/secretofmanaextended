param(
    [string]$SourceManifestPath = "",
    [string]$TargetProfile = "native32_tall",
    [int]$PaddingPx = 2,
    [string]$OutputManifestPath = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-RepoPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RelativePath
    )

    $repoRoot = Split-Path -Parent $PSScriptRoot
    return [System.IO.Path]::GetFullPath((Join-Path $repoRoot $RelativePath))
}

if ([string]::IsNullOrWhiteSpace($SourceManifestPath)) {
    $SourceManifestPath = Resolve-RepoPath "game/art/ch01/characters/randi/source_pages/manifests/randi_hero64_tall_pose_crop_manifest.json"
} else {
    $SourceManifestPath = [System.IO.Path]::GetFullPath($SourceManifestPath)
}

$sourceManifest = Get-Content -Raw -Path $SourceManifestPath | ConvertFrom-Json
$normalizedManifestPath = Resolve-RepoPath $sourceManifest.source_manifest
$normalizedManifest = Get-Content -Raw -Path $normalizedManifestPath | ConvertFrom-Json

$profileMap = @{}
foreach ($property in $normalizedManifest.target_profiles.PSObject.Properties) {
    $profileMap[$property.Name] = $property.Value
}

if (-not $profileMap.ContainsKey($TargetProfile)) {
    throw "Target profile '$TargetProfile' was not found in normalized manifest."
}

if ([string]::IsNullOrWhiteSpace($OutputManifestPath)) {
    $manifestDir = Split-Path -Parent $SourceManifestPath
    $OutputManifestPath = Join-Path $manifestDir ("randi_{0}_pose_crop_manifest.json" -f $TargetProfile)
} else {
    $OutputManifestPath = [System.IO.Path]::GetFullPath($OutputManifestPath)
}

$targetProfileData = $profileMap[$TargetProfile]
$converted = [ordered]@{
    schema_version = [int]$sourceManifest.schema_version
    subject = [string]$sourceManifest.subject
    target_profile = $TargetProfile
    target_atlas = [ordered]@{
        cell_px = [int]$targetProfileData.cell_px
        columns = [int]$targetProfileData.columns
        rows = [int]$targetProfileData.rows
        atlas_px = @(
            [int]$targetProfileData.atlas_px[0],
            [int]$targetProfileData.atlas_px[1]
        )
    }
    source_manifest = [string]$sourceManifest.source_manifest
    default_fit = [ordered]@{
        mode = [string]$sourceManifest.default_fit.mode
        padding_px = $PaddingPx
    }
    notes = @($sourceManifest.notes) + @(
        ("This manifest was derived from {0} for strict {1} atlas comparison." -f [System.IO.Path]::GetFileName($SourceManifestPath), $TargetProfile)
    )
    entries = @($sourceManifest.entries)
    reference_gaps = @($sourceManifest.reference_gaps)
}

$json = $converted | ConvertTo-Json -Depth 8
[System.IO.File]::WriteAllText($OutputManifestPath, $json + [Environment]::NewLine)
Write-Output "Wrote $OutputManifestPath"
