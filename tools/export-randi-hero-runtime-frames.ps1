param(
    [string]$PoseManifestPath = "",
    [string]$OutputDirectory = "",
    [switch]$BuildContactSheet
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
        [int]$CellPx,
        [Parameter(Mandatory = $true)]
        [int]$PaddingPx,
        [object]$RenderOptions = $null
    )

    $sourceRect = New-Object System.Drawing.Rectangle $CropRect[0], $CropRect[1], $CropRect[2], $CropRect[3]
    $innerWidth = $CellPx - ($PaddingPx * 2)
    $innerHeight = $CellPx - ($PaddingPx * 2)
    $scaleX = $innerWidth / [double]$sourceRect.Width
    $scaleY = $innerHeight / [double]$sourceRect.Height
    $scale = [Math]::Min($scaleX, $scaleY)
    $scaleMultiplier = 1.0
    $offsetX = 0
    $offsetY = 0
    $flipH = $false

    if ($RenderOptions) {
        if ($RenderOptions.PSObject.Properties.Name -contains "scale_multiplier") {
            $scaleMultiplier = [double]$RenderOptions.scale_multiplier
        }
        if ($RenderOptions.PSObject.Properties.Name -contains "offset_px" -and $RenderOptions.offset_px.Count -ge 2) {
            $offsetX = [int]$RenderOptions.offset_px[0]
            $offsetY = [int]$RenderOptions.offset_px[1]
        }
        if ($RenderOptions.PSObject.Properties.Name -contains "flip_h") {
            $flipH = [bool]$RenderOptions.flip_h
        }
    }

    $scale *= $scaleMultiplier
    $drawWidth = [Math]::Max(1, [int][Math]::Round($sourceRect.Width * $scale))
    $drawHeight = [Math]::Max(1, [int][Math]::Round($sourceRect.Height * $scale))
    $drawX = [int][Math]::Round(($CellPx - $drawWidth) / 2.0) + $offsetX
    $drawY = $CellPx - $PaddingPx - $drawHeight + $offsetY

    $destinationRect = New-Object System.Drawing.Rectangle $drawX, $drawY, $drawWidth, $drawHeight
    if (-not $flipH) {
        $Graphics.DrawImage($SourceBitmap, $destinationRect, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
        return
    }

    $state = $Graphics.Save()
    try {
        $Graphics.TranslateTransform($drawX + $drawWidth, $drawY)
        $Graphics.ScaleTransform(-1.0, 1.0)
        $flippedDestination = New-Object System.Drawing.Rectangle 0, 0, $drawWidth, $drawHeight
        $Graphics.DrawImage($SourceBitmap, $flippedDestination, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
    }
    finally {
        $Graphics.Restore($state)
    }
}

function Build-ContactSheet {
    param(
        [Parameter(Mandatory = $true)]
        [string]$DirectoryPath
    )

    $pngFiles = Get-ChildItem -LiteralPath $DirectoryPath -Filter *.png -File |
        Where-Object { $_.BaseName -ne "randi_hero_sheet" } |
        Sort-Object Name

    if ($pngFiles.Count -eq 0) {
        return
    }

    $tileWidth = 84
    $tileHeight = 104
    $sheetColumns = 4
    $sheetRows = [Math]::Ceiling($pngFiles.Count / [double]$sheetColumns)
    $sheetBitmap = New-TransparentBitmap -Width ($sheetColumns * $tileWidth) -Height ([int]($sheetRows * $tileHeight))
    $sheetGraphics = [System.Drawing.Graphics]::FromImage($sheetBitmap)
    $sheetGraphics.Clear([System.Drawing.Color]::FromArgb(255, 44, 49, 56))
    $sheetGraphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $sheetGraphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $sheetGraphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $font = New-Object System.Drawing.Font "Segoe UI", 7
    $textBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 230, 230, 236))
    $frameBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 58, 64, 72))
    $framePen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 92, 98, 108)), 1

    try {
        for ($index = 0; $index -lt $pngFiles.Count; $index++) {
            $file = $pngFiles[$index]
            $tileCol = $index % $sheetColumns
            $tileRow = [Math]::Floor($index / $sheetColumns)
            $tileX = $tileCol * $tileWidth
            $tileY = $tileRow * $tileHeight

            $frameRect = New-Object System.Drawing.Rectangle ($tileX + 8), ($tileY + 8), 68, 68
            $sheetGraphics.FillRectangle($frameBrush, $frameRect)
            $sheetGraphics.DrawRectangle($framePen, $frameRect)

            $texture = [System.Drawing.Bitmap]::FromFile($file.FullName)
            try {
                $sheetGraphics.DrawImage($texture, $frameRect)
            }
            finally {
                $texture.Dispose()
            }

            $sheetGraphics.DrawString($file.BaseName, $font, $textBrush, ($tileX + 8), ($tileY + 80))
        }

        $contactPath = Join-Path $DirectoryPath "randi_hero_sheet.png"
        $sheetBitmap.Save($contactPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $framePen.Dispose()
        $frameBrush.Dispose()
        $textBrush.Dispose()
        $font.Dispose()
        $sheetGraphics.Dispose()
        $sheetBitmap.Dispose()
    }
}

if ([string]::IsNullOrWhiteSpace($PoseManifestPath)) {
    $PoseManifestPath = Resolve-RepoPath "game/art/ch01/characters/randi/source_pages/manifests/randi_hero64_tall_pose_crop_manifest.json"
} else {
    $PoseManifestPath = [System.IO.Path]::GetFullPath($PoseManifestPath)
}

if ([string]::IsNullOrWhiteSpace($OutputDirectory)) {
    $OutputDirectory = Resolve-RepoPath "game/art/ch01/characters/randi/hero"
} else {
    $OutputDirectory = [System.IO.Path]::GetFullPath($OutputDirectory)
}

$poseManifest = Get-Content -Raw -Path $PoseManifestPath | ConvertFrom-Json
$normalizedManifestPath = Resolve-RepoPath $poseManifest.source_manifest
$normalizedManifest = Get-Content -Raw -Path $normalizedManifestPath | ConvertFrom-Json
$pageMap = Get-PageMap -NormalizedManifest $normalizedManifest
$cellPx = [int]$poseManifest.target_atlas.cell_px
$paddingPx = [int]$poseManifest.default_fit.padding_px

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
}

$pageBitmaps = @{}
$writeCount = 0

try {
    foreach ($entry in $poseManifest.entries) {
        $pageId = [string]$entry.source.page_id
        $renderOptions = if ($entry.PSObject.Properties.Name -contains "render") { $entry.render } else { $null }
        if (-not $pageMap.ContainsKey($pageId)) {
            throw "Source page '$pageId' was not found in normalized manifest."
        }

        if (-not $pageBitmaps.ContainsKey($pageId)) {
            $pageBitmaps[$pageId] = [System.Drawing.Bitmap]::FromFile($pageMap[$pageId].png_path)
        }

        $targetClip = [string]$entry.target_clip
        $targetPath = Join-Path $OutputDirectory ("{0}_{1}.png" -f $targetClip, [int]$entry.frame_index)
        $cropRect = @(
            [int]$entry.source.crop_rect[0],
            [int]$entry.source.crop_rect[1],
            [int]$entry.source.crop_rect[2],
            [int]$entry.source.crop_rect[3]
        )

        $frameBitmap = New-TransparentBitmap -Width $cellPx -Height $cellPx
        $frameGraphics = [System.Drawing.Graphics]::FromImage($frameBitmap)
        $frameGraphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
        $frameGraphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $frameGraphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $frameGraphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $frameGraphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality

        try {
            Draw-FitCrop -Graphics $frameGraphics -SourceBitmap $pageBitmaps[$pageId] -CropRect $cropRect -CellPx $cellPx -PaddingPx $paddingPx -RenderOptions $renderOptions
            $frameBitmap.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
            $writeCount++
        }
        finally {
            $frameGraphics.Dispose()
            $frameBitmap.Dispose()
        }
    }

    if ($BuildContactSheet) {
        Build-ContactSheet -DirectoryPath $OutputDirectory
    }

    Write-Output "Exported $writeCount runtime frames to $OutputDirectory"
}
finally {
    foreach ($bitmap in $pageBitmaps.Values) {
        $bitmap.Dispose()
    }
}
