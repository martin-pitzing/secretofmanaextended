param(
    [string]$SourceDir = "pictures_artworks",
    [string]$ManifestPath = "pictures_artworks/pipeline_manifest.json",
    [string]$OutputRoot = "game/art/ch01/characters/randi/source_pages",
    [string]$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

function New-Color {
    param(
        [Parameter(Mandatory = $true)][string]$Hex,
        [int]$Alpha = 255
    )

    $clean = $Hex.TrimStart("#")
    $r = [Convert]::ToInt32($clean.Substring(0, 2), 16)
    $g = [Convert]::ToInt32($clean.Substring(2, 2), 16)
    $b = [Convert]::ToInt32($clean.Substring(4, 2), 16)
    return [System.Drawing.Color]::FromArgb($Alpha, $r, $g, $b)
}

function Get-SvgMetadata {
    param(
        [Parameter(Mandatory = $true)][string]$Path
    )

    $firstLine = Get-Content -Path $Path -TotalCount 1

    $viewBoxMatch = [regex]::Match($firstLine, 'viewBox="([^"]+)"')
    $widthMatch = [regex]::Match($firstLine, 'width="([^"]+)"')
    $heightMatch = [regex]::Match($firstLine, 'height="([^"]+)"')

    if (-not $viewBoxMatch.Success -or -not $widthMatch.Success -or -not $heightMatch.Success) {
        throw "Could not parse svg metadata from '$Path'."
    }

    $viewBoxParts = $viewBoxMatch.Groups[1].Value.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)
    $widthValue = [int][math]::Round([double]$widthMatch.Groups[1].Value)
    $heightValue = [int][math]::Round([double]$heightMatch.Groups[1].Value)

    return @{
        viewbox_x = [double]$viewBoxParts[0]
        viewbox_y = [double]$viewBoxParts[1]
        viewbox_width = [double]$viewBoxParts[2]
        viewbox_height = [double]$viewBoxParts[3]
        render_width = $widthValue
        render_height = $heightValue
    }
}

function New-DirectorySafe {
    param([string]$Path)
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Invoke-ChromeRasterize {
    param(
        [Parameter(Mandatory = $true)][string]$ChromeExe,
        [Parameter(Mandatory = $true)][string]$SvgPath,
        [Parameter(Mandatory = $true)][string]$OutputPath,
        [Parameter(Mandatory = $true)][int]$Width,
        [Parameter(Mandatory = $true)][int]$Height
    )

    $userDataDir = Join-Path ([System.IO.Path]::GetTempPath()) ("somr-svg-" + [guid]::NewGuid().ToString("N"))
    New-DirectorySafe -Path $userDataDir

    try {
        $fileUrl = "file:///" + $SvgPath.Replace("\", "/")
        & $ChromeExe `
            --headless=new `
            --disable-gpu `
            --no-first-run `
            --no-default-browser-check `
            --user-data-dir=$userDataDir `
            --hide-scrollbars `
            --window-size=$Width,$Height `
            --screenshot=$OutputPath `
            $fileUrl | Out-Null
    }
    finally {
        if (Test-Path -LiteralPath $userDataDir) {
            Remove-Item -LiteralPath $userDataDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

function New-GridTemplate {
    param(
        [Parameter(Mandatory = $true)][string]$OutputPath,
        [Parameter(Mandatory = $true)][int]$Columns,
        [Parameter(Mandatory = $true)][int]$Rows,
        [Parameter(Mandatory = $true)][int]$CellSize,
        [Parameter(Mandatory = $true)][string]$Label
    )

    $width = $Columns * $CellSize
    $height = $Rows * $CellSize
    $bitmap = New-Object System.Drawing.Bitmap $width, $height, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $background = New-Object System.Drawing.SolidBrush((New-Color "#0F1318"))
    $panelA = New-Object System.Drawing.SolidBrush((New-Color "#1B232D"))
    $panelB = New-Object System.Drawing.SolidBrush((New-Color "#16202A"))
    $gridPen = New-Object System.Drawing.Pen((New-Color "#5D6A78"), 1)
    $font = New-Object System.Drawing.Font("Arial", [float][math]::Max(8, $CellSize * 0.25), [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
    $brush = New-Object System.Drawing.SolidBrush((New-Color "#D9C8A6"))

    try {
        $graphics.FillRectangle($background, 0, 0, $width, $height)

        for ($row = 0; $row -lt $Rows; $row++) {
            for ($col = 0; $col -lt $Columns; $col++) {
                $x = $col * $CellSize
                $y = $row * $CellSize
                $cellBrush = if ((($row + $col) % 2) -eq 0) { $panelA } else { $panelB }
                $graphics.FillRectangle($cellBrush, $x, $y, $CellSize, $CellSize)
                $graphics.DrawRectangle($gridPen, $x, $y, $CellSize, $CellSize)
            }
        }

        $graphics.DrawString($Label, $font, $brush, [System.Drawing.PointF]::new(6, 6))
        $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $brush.Dispose()
        $font.Dispose()
        $gridPen.Dispose()
        $panelA.Dispose()
        $panelB.Dispose()
        $background.Dispose()
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

function New-ContactSheet {
    param(
        [Parameter(Mandatory = $true)][array]$Pages,
        [Parameter(Mandatory = $true)][string]$OutputPath
    )

    $thumbWidth = 320
    $thumbHeight = 428
    $columns = 2
    $rows = [int][math]::Ceiling($Pages.Count / [double]$columns)
    $sheetWidth = ($columns * 340)
    $sheetHeight = ($rows * 470)

    $bitmap = New-Object System.Drawing.Bitmap $sheetWidth, $sheetHeight, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $background = New-Object System.Drawing.SolidBrush((New-Color "#10151B"))
    $panelBrush = New-Object System.Drawing.SolidBrush((New-Color "#1E2730"))
    $font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
    $brush = New-Object System.Drawing.SolidBrush((New-Color "#E6D9BD"))
    $borderPen = New-Object System.Drawing.Pen((New-Color "#44505D"), 1)

    try {
        $graphics.Clear((New-Color "#10151B"))
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

        for ($index = 0; $index -lt $Pages.Count; $index++) {
            $page = $Pages[$index]
            $col = $index % $columns
            $row = [int][math]::Floor($index / $columns)
            $panelX = 10 + ($col * 340)
            $panelY = 10 + ($row * 470)

            $graphics.FillRectangle($panelBrush, $panelX, $panelY, 330, 460)
            $graphics.DrawRectangle($borderPen, $panelX, $panelY, 330, 460)

            $image = [System.Drawing.Image]::FromFile($page.png_path)
            try {
                $graphics.DrawImage($image, [System.Drawing.Rectangle]::new($panelX + 5, $panelY + 5, $thumbWidth, $thumbHeight))
            }
            finally {
                $image.Dispose()
            }

            $label = "{0}`n{1}" -f $page.id, $page.page_type
            $graphics.DrawString($label, $font, $brush, [System.Drawing.PointF]::new($panelX + 8, $panelY + 438))
        }

        $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $borderPen.Dispose()
        $brush.Dispose()
        $font.Dispose()
        $panelBrush.Dispose()
        $background.Dispose()
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

$workspaceRoot = (Resolve-Path ".").Path
$resolvedSourceDir = (Resolve-Path $SourceDir).Path
$resolvedManifestPath = (Resolve-Path $ManifestPath).Path
$resolvedOutputRoot = Join-Path $workspaceRoot $OutputRoot
$svgMasterDir = Join-Path $resolvedOutputRoot "svg_master"
$pngMasterDir = Join-Path $resolvedOutputRoot "png_master"
$contactDir = Join-Path $resolvedOutputRoot "contact"
$templateDir = Join-Path $resolvedOutputRoot "templates"
$manifestsDir = Join-Path $resolvedOutputRoot "manifests"

foreach ($dir in @($resolvedOutputRoot, $svgMasterDir, $pngMasterDir, $contactDir, $templateDir, $manifestsDir)) {
    New-DirectorySafe -Path $dir
}

if (-not (Test-Path -LiteralPath $ChromePath)) {
    throw "Chrome executable not found at '$ChromePath'."
}

$manifest = Get-Content -Path $resolvedManifestPath -Raw | ConvertFrom-Json
$normalizedPages = @()

foreach ($source in $manifest.sources) {
    $sourceSvgPath = Join-Path $resolvedSourceDir $source.source_file
    if (-not (Test-Path -LiteralPath $sourceSvgPath)) {
        throw "Missing source svg '$sourceSvgPath'."
    }

    $svgMetadata = Get-SvgMetadata -Path $sourceSvgPath
    $svgOutputPath = Join-Path $svgMasterDir ($source.id + ".svg")
    $pngOutputPath = Join-Path $pngMasterDir ($source.id + ".png")

    Copy-Item -LiteralPath $sourceSvgPath -Destination $svgOutputPath -Force
    Invoke-ChromeRasterize -ChromeExe $ChromePath -SvgPath $sourceSvgPath -OutputPath $pngOutputPath -Width $svgMetadata.render_width -Height $svgMetadata.render_height

    $normalizedPages += [ordered]@{
        id = [string]$source.id
        page_type = [string]$source.page_type
        source_file = [string]$source.source_file
        svg_path = $svgOutputPath
        png_path = $pngOutputPath
        source_render_width = $svgMetadata.render_width
        source_render_height = $svgMetadata.render_height
        source_viewbox_width = $svgMetadata.viewbox_width
        source_viewbox_height = $svgMetadata.viewbox_height
        clip_groups = @($source.clip_groups)
    }
}

$normalizedManifest = [ordered]@{
    schema_version = $manifest.schema_version
    subject = $manifest.subject
    notes = @($manifest.notes)
    target_profiles = $manifest.target_profiles
    imported_at = (Get-Date).ToString("s")
    pages = $normalizedPages
}

$normalizedManifestPath = Join-Path $manifestsDir "normalized_manifest.json"
$normalizedManifest | ConvertTo-Json -Depth 8 | Set-Content -Path $normalizedManifestPath -Encoding UTF8

New-ContactSheet -Pages $normalizedPages -OutputPath (Join-Path $contactDir "pages_contact_sheet.png")

foreach ($profileName in $manifest.target_profiles.PSObject.Properties.Name) {
    $profile = $manifest.target_profiles.$profileName
    $cols = [int]$profile.columns
    $rows = [int]$profile.rows
    $cell = [int]$profile.cell_px
    $label = "{0} | {1}x{2} cells | {3}px" -f $profileName, $cols, $rows, $cell
    New-GridTemplate -OutputPath (Join-Path $templateDir ($profileName + ".png")) -Columns $cols -Rows $rows -CellSize $cell -Label $label
}

Write-Output "Imported pictures_artworks into $resolvedOutputRoot"
