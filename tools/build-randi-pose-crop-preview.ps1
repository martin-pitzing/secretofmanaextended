param(
    [string]$PoseManifestPath = "",
    [switch]$EmitContactSheet
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

function Resolve-RepoPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RelativePath
    )

    $repoRoot = Split-Path -Parent $PSScriptRoot
    return [System.IO.Path]::GetFullPath((Join-Path $repoRoot $RelativePath))
}

function New-TransparentBitmap {
    param(
        [Parameter(Mandatory = $true)]
        [int]$Width,
        [Parameter(Mandatory = $true)]
        [int]$Height
    )

    $bitmap = New-Object System.Drawing.Bitmap $Width, $Height
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.Clear([System.Drawing.Color]::Transparent)
    $graphics.Dispose()
    return $bitmap
}

function Get-PageMap {
    param(
        [Parameter(Mandatory = $true)]
        [object]$NormalizedManifest
    )

    $pageMap = @{}
    foreach ($page in $NormalizedManifest.pages) {
        $pageMap[$page.id] = $page
    }

    return $pageMap
}

function Draw-FitCrop {
    param(
        [Parameter(Mandatory = $true)]
        [System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)]
        [System.Drawing.Bitmap]$SourceBitmap,
        [Parameter(Mandatory = $true)]
        [int[]]$CropRect,
        [Parameter(Mandatory = $true)]
        [int]$CellX,
        [Parameter(Mandatory = $true)]
        [int]$CellY,
        [Parameter(Mandatory = $true)]
        [int]$CellPx,
        [Parameter(Mandatory = $true)]
        [int]$PaddingPx
    )

    $sourceRect = New-Object System.Drawing.Rectangle $CropRect[0], $CropRect[1], $CropRect[2], $CropRect[3]

    $innerWidth = $CellPx - ($PaddingPx * 2)
    $innerHeight = $CellPx - ($PaddingPx * 2)
    if ($innerWidth -le 0 -or $innerHeight -le 0) {
        throw "Invalid cell padding for cell size $CellPx."
    }

    $scaleX = $innerWidth / [double]$sourceRect.Width
    $scaleY = $innerHeight / [double]$sourceRect.Height
    $scale = [Math]::Min($scaleX, $scaleY)
    $drawWidth = [Math]::Max(1, [int][Math]::Round($sourceRect.Width * $scale))
    $drawHeight = [Math]::Max(1, [int][Math]::Round($sourceRect.Height * $scale))
    $drawX = $CellX + [int][Math]::Round(($CellPx - $drawWidth) / 2.0)
    $drawY = $CellY + $CellPx - $PaddingPx - $drawHeight

    $destinationRect = New-Object System.Drawing.Rectangle $drawX, $drawY, $drawWidth, $drawHeight
    $Graphics.DrawImage($SourceBitmap, $destinationRect, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
}

function Draw-CellGuides {
    param(
        [Parameter(Mandatory = $true)]
        [System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)]
        [int]$Columns,
        [Parameter(Mandatory = $true)]
        [int]$Rows,
        [Parameter(Mandatory = $true)]
        [int]$CellPx
    )

    $guidePen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(48, 255, 255, 255)), 1
    for ($col = 0; $col -le $Columns; $col++) {
        $x = $col * $CellPx
        $Graphics.DrawLine($guidePen, $x, 0, $x, $Rows * $CellPx)
    }
    for ($row = 0; $row -le $Rows; $row++) {
        $y = $row * $CellPx
        $Graphics.DrawLine($guidePen, 0, $y, $Columns * $CellPx, $y)
    }
    $guidePen.Dispose()
}

if ([string]::IsNullOrWhiteSpace($PoseManifestPath)) {
    $PoseManifestPath = Resolve-RepoPath "game/art/ch01/characters/randi/source_pages/manifests/randi_hero64_tall_pose_crop_manifest.json"
} else {
    $PoseManifestPath = [System.IO.Path]::GetFullPath($PoseManifestPath)
}

$poseManifest = Get-Content -Raw -Path $PoseManifestPath | ConvertFrom-Json
$normalizedManifestPath = Resolve-RepoPath $poseManifest.source_manifest
$normalizedManifest = Get-Content -Raw -Path $normalizedManifestPath | ConvertFrom-Json
$pageMap = Get-PageMap -NormalizedManifest $normalizedManifest
$outputBaseName = [System.IO.Path]::GetFileNameWithoutExtension($PoseManifestPath) -replace "_manifest$", ""

$cellPx = [int]$poseManifest.target_atlas.cell_px
$columns = [int]$poseManifest.target_atlas.columns
$rows = [int]$poseManifest.target_atlas.rows
$atlasWidth = [int]$poseManifest.target_atlas.atlas_px[0]
$atlasHeight = [int]$poseManifest.target_atlas.atlas_px[1]
$paddingPx = [int]$poseManifest.default_fit.padding_px

$atlasBitmap = New-TransparentBitmap -Width $atlasWidth -Height $atlasHeight
$atlasGraphics = [System.Drawing.Graphics]::FromImage($atlasBitmap)
$atlasGraphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
$atlasGraphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$atlasGraphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$atlasGraphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$atlasGraphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality

$atlasGraphics.Clear([System.Drawing.Color]::Transparent)

$pageBitmaps = @{}
$entryCounter = 0

try {
    foreach ($entry in $poseManifest.entries) {
        $pageId = [string]$entry.source.page_id
        if (-not $pageMap.ContainsKey($pageId)) {
            throw "Source page '$pageId' was not found in normalized manifest."
        }

        if (-not $pageBitmaps.ContainsKey($pageId)) {
            $pageBitmaps[$pageId] = [System.Drawing.Bitmap]::FromFile($pageMap[$pageId].png_path)
        }

        $col = [int]$entry.atlas_cell.col
        $row = [int]$entry.atlas_cell.row
        $cellX = $col * $cellPx
        $cellY = $row * $cellPx
        $cropRect = @(
            [int]$entry.source.crop_rect[0],
            [int]$entry.source.crop_rect[1],
            [int]$entry.source.crop_rect[2],
            [int]$entry.source.crop_rect[3]
        )

        Draw-FitCrop `
            -Graphics $atlasGraphics `
            -SourceBitmap $pageBitmaps[$pageId] `
            -CropRect $cropRect `
            -CellX $cellX `
            -CellY $cellY `
            -CellPx $cellPx `
            -PaddingPx $paddingPx

        $entryCounter++
    }

    Draw-CellGuides -Graphics $atlasGraphics -Columns $columns -Rows $rows -CellPx $cellPx

    $manifestDir = Split-Path -Parent $PoseManifestPath
    $sourcePagesDir = Split-Path -Parent $manifestDir
    $contactDir = Join-Path $sourcePagesDir "contact"
    if (-not (Test-Path -LiteralPath $contactDir)) {
        New-Item -ItemType Directory -Path $contactDir | Out-Null
    }

    $atlasPreviewPath = Join-Path $contactDir ("{0}_preview.png" -f $outputBaseName)
    $atlasBitmap.Save($atlasPreviewPath, [System.Drawing.Imaging.ImageFormat]::Png)

    if ($EmitContactSheet) {
        $tileWidth = 120
        $tileHeight = 128
        $labelBandHeight = 30
        $sheetColumns = 4
        $entryList = @($poseManifest.entries)
        $sheetRows = [Math]::Ceiling($entryList.Count / [double]$sheetColumns)
        $sheetBitmap = New-TransparentBitmap -Width ($sheetColumns * $tileWidth) -Height ([int]($sheetRows * $tileHeight))
        $sheetGraphics = [System.Drawing.Graphics]::FromImage($sheetBitmap)
        $sheetGraphics.Clear([System.Drawing.Color]::FromArgb(255, 24, 24, 28))
        $sheetGraphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $sheetGraphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $sheetGraphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $sheetGraphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality

        $font = New-Object System.Drawing.Font "Segoe UI", 8
        $brush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 230, 230, 236))
        $frameBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 36, 42, 52))
        $guidePen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 80, 90, 110)), 1

        for ($index = 0; $index -lt $entryList.Count; $index++) {
            $entry = $entryList[$index]
            $tileCol = $index % $sheetColumns
            $tileRow = [Math]::Floor($index / $sheetColumns)
            $tileX = $tileCol * $tileWidth
            $tileY = $tileRow * $tileHeight
            $frameRect = New-Object System.Drawing.Rectangle ($tileX + 8), ($tileY + 8), 104, 82
            $sheetGraphics.FillRectangle($frameBrush, $frameRect)
            $sheetGraphics.DrawRectangle($guidePen, $frameRect)

            $pageId = [string]$entry.source.page_id
            $cropRect = @(
                [int]$entry.source.crop_rect[0],
                [int]$entry.source.crop_rect[1],
                [int]$entry.source.crop_rect[2],
                [int]$entry.source.crop_rect[3]
            )
            Draw-FitCrop `
                -Graphics $sheetGraphics `
                -SourceBitmap $pageBitmaps[$pageId] `
                -CropRect $cropRect `
                -CellX ($tileX + 28) `
                -CellY ($tileY + 12) `
                -CellPx 64 `
                -PaddingPx 2

            $label = "{0} [{1},{2}]" -f $entry.entry_id, $entry.atlas_cell.col, $entry.atlas_cell.row
            $sheetGraphics.DrawString($label, $font, $brush, ($tileX + 8), ($tileY + 94))
        }

        $contactPath = Join-Path $contactDir ("{0}_contact.png" -f $outputBaseName)
        $sheetBitmap.Save($contactPath, [System.Drawing.Imaging.ImageFormat]::Png)

        $guidePen.Dispose()
        $frameBrush.Dispose()
        $brush.Dispose()
        $font.Dispose()
        $sheetGraphics.Dispose()
        $sheetBitmap.Dispose()
    }

    Write-Output "Built $entryCounter pose crops into $atlasPreviewPath"
}
finally {
    foreach ($bitmap in $pageBitmaps.Values) {
        $bitmap.Dispose()
    }
    $atlasGraphics.Dispose()
    $atlasBitmap.Dispose()
}
