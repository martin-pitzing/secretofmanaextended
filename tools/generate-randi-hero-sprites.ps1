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

function New-SpriteBitmap {
    $bitmap = New-Object System.Drawing.Bitmap 64, 64, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    for ($yy = 0; $yy -lt 64; $yy++) {
        for ($xx = 0; $xx -lt 64; $xx++) {
            $bitmap.SetPixel($xx, $yy, [System.Drawing.Color]::Transparent)
        }
    }
    return $bitmap
}

function Set-PixelSafe {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [int]$X,
        [int]$Y,
        [System.Drawing.Color]$Color
    )

    if ($X -lt 0 -or $Y -lt 0 -or $X -ge $Bitmap.Width -or $Y -ge $Bitmap.Height) {
        return
    }
    $Bitmap.SetPixel($X, $Y, $Color)
}

function Fill-Rect {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [System.Drawing.Color]$Color
    )

    for ($yy = $Y; $yy -lt ($Y + $Height); $yy++) {
        for ($xx = $X; $xx -lt ($X + $Width); $xx++) {
            Set-PixelSafe -Bitmap $Bitmap -X $xx -Y $yy -Color $Color
        }
    }
}

function Fill-Circle {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [int]$CenterX,
        [int]$CenterY,
        [int]$Radius,
        [System.Drawing.Color]$Color
    )

    for ($yy = ($CenterY - $Radius); $yy -le ($CenterY + $Radius); $yy++) {
        for ($xx = ($CenterX - $Radius); $xx -le ($CenterX + $Radius); $xx++) {
            $dx = $xx - $CenterX
            $dy = $yy - $CenterY
            if (($dx * $dx) + ($dy * $dy) -le ($Radius * $Radius)) {
                Set-PixelSafe -Bitmap $Bitmap -X $xx -Y $yy -Color $Color
            }
        }
    }
}

function Save-Sprite {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [string]$Path
    )

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }
    $Bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
}

$outline = New-Color "#2A241F"
$skin = New-Color "#E3BC8A"
$hairDark = New-Color "#A87422"
$hairMid = New-Color "#E0B94A"
$hairLight = New-Color "#F6E18A"
$hoodDark = New-Color "#355227"
$hoodMid = New-Color "#4F7530"
$hoodLight = New-Color "#6B9840"
$clothDark = New-Color "#6A4A2F"
$clothMid = New-Color "#8B6542"
$strap = New-Color "#936E48"
$pants = New-Color "#595048"
$boot = New-Color "#3A312B"
$metal = New-Color "#CFD5D8"
$metalDark = New-Color "#8B959B"
$gold = New-Color "#C3A55B"

function Draw-HeadFront {
    param([System.Drawing.Bitmap]$Bitmap, [int]$X, [int]$Y)

    Fill-Rect $Bitmap ($X + 1) $Y 14 4 $hairDark
    Fill-Rect $Bitmap ($X + 2) ($Y + 1) 12 4 $hairMid
    Fill-Rect $Bitmap ($X + 4) ($Y + 1) 8 2 $hairLight
    Fill-Rect $Bitmap ($X + 3) ($Y + 4) 10 4 $skin
    Fill-Rect $Bitmap ($X + 2) ($Y + 4) 1 3 $skin
    Fill-Rect $Bitmap ($X + 13) ($Y + 4) 1 3 $skin
    Fill-Rect $Bitmap ($X + 2) ($Y + 5) 1 1 $hairMid
    Fill-Rect $Bitmap ($X + 13) ($Y + 5) 1 1 $hairMid
    Fill-Rect $Bitmap ($X + 6) ($Y + 6) 1 1 $outline
    Fill-Rect $Bitmap ($X + 10) ($Y + 6) 1 1 $outline
    Fill-Rect $Bitmap ($X + 7) ($Y + 8) 3 1 $outline
}

function Draw-HeadBack {
    param([System.Drawing.Bitmap]$Bitmap, [int]$X, [int]$Y)

    Fill-Rect $Bitmap ($X + 2) $Y 12 3 $hairDark
    Fill-Rect $Bitmap ($X + 3) ($Y + 1) 10 4 $hairMid
    Fill-Rect $Bitmap ($X + 5) ($Y + 1) 6 2 $hairLight
    Fill-Rect $Bitmap ($X + 1) ($Y + 4) 14 6 $hoodMid
    Fill-Rect $Bitmap ($X + 3) ($Y + 5) 10 2 $hoodLight
}

function Draw-HeadSide {
    param([System.Drawing.Bitmap]$Bitmap, [int]$X, [int]$Y)

    Fill-Rect $Bitmap $X $Y 11 4 $hairDark
    Fill-Rect $Bitmap ($X + 1) ($Y + 1) 10 4 $hairMid
    Fill-Rect $Bitmap ($X + 2) ($Y + 1) 7 2 $hairLight
    Fill-Rect $Bitmap ($X + 4) ($Y + 4) 6 4 $skin
    Fill-Rect $Bitmap ($X + 10) ($Y + 5) 1 2 $skin
    Fill-Rect $Bitmap ($X + 3) ($Y + 5) 1 1 $skin
    Fill-Rect $Bitmap ($X + 7) ($Y + 6) 1 1 $outline
}

function Draw-SwordDown {
    param([System.Drawing.Bitmap]$Bitmap, [int]$X, [int]$Y, [int]$Height)

    Fill-Rect $Bitmap $X $Y 2 $Height $metalDark
    Fill-Rect $Bitmap ($X + 2) $Y 2 $Height $metal
    Fill-Rect $Bitmap ($X - 1) ($Y + $Height - 2) 5 2 $strap
}

function Draw-SwordSide {
    param([System.Drawing.Bitmap]$Bitmap, [int]$X, [int]$Y, [int]$Length)

    Fill-Rect $Bitmap $X $Y $Length 2 $metalDark
    Fill-Rect $Bitmap ($X + 1) ($Y - 1) ($Length - 1) 2 $metal
    Fill-Rect $Bitmap ($X - 3) ($Y - 1) 4 4 $strap
}

function Draw-RandiDownFrame {
    param([string]$Mode, [int]$FrameIndex)

    $bmp = New-SpriteBitmap
    $phaseDefs = @{
        idle = @(
            @{ bob = 0; leftLeg = 0; rightLeg = 0; swordY = 0; satchelX = 0 }
            @{ bob = -1; leftLeg = -1; rightLeg = 1; swordY = -1; satchelX = 0 }
        )
        walk = @(
            @{ bob = 0; leftLeg = -2; rightLeg = 1; swordY = 0; satchelX = -1 }
            @{ bob = -1; leftLeg = -1; rightLeg = 2; swordY = -1; satchelX = 0 }
            @{ bob = 0; leftLeg = 1; rightLeg = -2; swordY = 0; satchelX = 1 }
            @{ bob = 1; leftLeg = 2; rightLeg = -1; swordY = 1; satchelX = 0 }
        )
        run = @(
            @{ bob = 1; leftLeg = -3; rightLeg = 2; swordY = 1; satchelX = -1 }
            @{ bob = -1; leftLeg = -1; rightLeg = 3; swordY = -1; satchelX = 1 }
            @{ bob = 1; leftLeg = 3; rightLeg = -3; swordY = 1; satchelX = 1 }
            @{ bob = 0; leftLeg = 2; rightLeg = -1; swordY = 0; satchelX = -1 }
        )
    }

    $phase = $phaseDefs[$Mode][$FrameIndex]
    $baseY = 8 + [int]$phase.bob

    Draw-HeadFront $bmp 24 $baseY
    Fill-Rect $bmp 20 ($baseY + 18) 24 5 $hoodDark
    Fill-Rect $bmp 21 ($baseY + 19) 22 11 $hoodMid
    Fill-Rect $bmp 24 ($baseY + 20) 16 4 $hoodLight
    Fill-Rect $bmp (20 + [int]$phase.satchelX) ($baseY + 27) 6 7 $clothMid
    Fill-Rect $bmp 25 ($baseY + 30) 14 3 $strap
    Fill-Rect $bmp 30 ($baseY + 30) 4 3 $gold
    Fill-Rect $bmp 18 ($baseY + 22) 4 12 $clothDark
    Fill-Rect $bmp 42 ($baseY + 22) 4 12 $clothDark
    Fill-Rect $bmp 19 ($baseY + 23) 2 7 $skin
    Fill-Rect $bmp 43 ($baseY + 23) 2 7 $skin
    Fill-Rect $bmp 27 ($baseY + 33) 6 9 $pants
    Fill-Rect $bmp 33 ($baseY + 33) 6 9 $pants
    Fill-Rect $bmp (27 + [int]$phase.leftLeg) ($baseY + 42) 5 8 $boot
    Fill-Rect $bmp (35 + [int]$phase.rightLeg) ($baseY + 42) 5 8 $boot
    Draw-SwordDown $bmp 46 ($baseY + 26 + [int]$phase.swordY) 17
    return $bmp
}

function Draw-RandiUpFrame {
    param([string]$Mode, [int]$FrameIndex)

    $bmp = New-SpriteBitmap
    $phaseDefs = @{
        idle = @(
            @{ bob = 0; cape = 0; swordY = 0; satchelX = 0; leftLeg = 0; rightLeg = 0 }
            @{ bob = -1; cape = 1; swordY = -1; satchelX = 0; leftLeg = -1; rightLeg = 1 }
        )
        walk = @(
            @{ bob = 0; cape = 0; swordY = 0; satchelX = -1; leftLeg = -2; rightLeg = 1 }
            @{ bob = -1; cape = 1; swordY = -1; satchelX = 0; leftLeg = -1; rightLeg = 2 }
            @{ bob = 0; cape = 2; swordY = 0; satchelX = 1; leftLeg = 1; rightLeg = -2 }
            @{ bob = 1; cape = 1; swordY = 1; satchelX = 0; leftLeg = 2; rightLeg = -1 }
        )
        run = @(
            @{ bob = 1; cape = 2; swordY = 1; satchelX = -1; leftLeg = -3; rightLeg = 2 }
            @{ bob = -1; cape = 3; swordY = -1; satchelX = 1; leftLeg = -1; rightLeg = 3 }
            @{ bob = 1; cape = 4; swordY = 1; satchelX = 1; leftLeg = 3; rightLeg = -3 }
            @{ bob = 0; cape = 3; swordY = 0; satchelX = -1; leftLeg = 2; rightLeg = -1 }
        )
    }

    $phase = $phaseDefs[$Mode][$FrameIndex]
    $baseY = 8 + [int]$phase.bob

    Draw-HeadBack $bmp 24 $baseY
    Fill-Rect $bmp 20 ($baseY + 17) 24 5 $hoodDark
    Fill-Rect $bmp 18 ($baseY + 21) 28 17 $hoodMid
    Fill-Rect $bmp 22 ($baseY + 22) 20 12 $hoodLight
    Fill-Rect $bmp 23 ($baseY + 35) 18 3 $strap
    Fill-Rect $bmp 29 ($baseY + 35) 4 3 $gold
    Fill-Rect $bmp (38 + [int]$phase.satchelX) ($baseY + 29) 6 7 $clothMid
    Fill-Rect $bmp 25 ($baseY + 38) 6 10 $pants
    Fill-Rect $bmp 33 ($baseY + 38) 6 10 $pants
    Fill-Rect $bmp (24 + [int]$phase.leftLeg) ($baseY + 48) 6 7 $boot
    Fill-Rect $bmp (34 + [int]$phase.rightLeg) ($baseY + 48) 6 7 $boot
    Draw-SwordDown $bmp 19 ($baseY + 29 + [int]$phase.swordY) 18
    return $bmp
}

function Draw-RandiSideFrame {
    param([string]$Mode, [int]$FrameIndex)

    $bmp = New-SpriteBitmap
    $phaseDefs = @{
        idle = @(
            @{ bob = 0; lean = 0; frontLeg = 0; backLeg = 0; swordX = 0; cape = 0 }
            @{ bob = -1; lean = 0; frontLeg = 1; backLeg = -1; swordX = 0; cape = 1 }
        )
        walk = @(
            @{ bob = 0; lean = 0; frontLeg = 2; backLeg = -2; swordX = 0; cape = 1 }
            @{ bob = -1; lean = 1; frontLeg = 1; backLeg = -1; swordX = 1; cape = 2 }
            @{ bob = 0; lean = 0; frontLeg = -2; backLeg = 2; swordX = 0; cape = 1 }
            @{ bob = 1; lean = -1; frontLeg = -1; backLeg = 1; swordX = -1; cape = 0 }
        )
        run = @(
            @{ bob = 1; lean = 2; frontLeg = 4; backLeg = -3; swordX = 2; cape = 3 }
            @{ bob = -1; lean = 3; frontLeg = 2; backLeg = -1; swordX = 3; cape = 4 }
            @{ bob = 1; lean = 2; frontLeg = -3; backLeg = 3; swordX = 2; cape = 3 }
            @{ bob = 0; lean = 1; frontLeg = -1; backLeg = 1; swordX = 1; cape = 2 }
        )
    }

    $phase = $phaseDefs[$Mode][$FrameIndex]
    $baseY = 10 + [int]$phase.bob
    $baseX = 20 + [int]$phase.lean

    Draw-HeadSide $bmp ($baseX + 11) $baseY
    Fill-Rect $bmp ($baseX + 8) ($baseY + 18) 17 5 $hoodDark
    Fill-Rect $bmp ($baseX + 7 - [int]$phase.cape) ($baseY + 21) 18 13 $hoodMid
    Fill-Rect $bmp ($baseX + 10 - [int]$phase.cape) ($baseY + 22) 12 4 $hoodLight
    Fill-Rect $bmp ($baseX + 12) ($baseY + 27) 10 3 $strap
    Fill-Rect $bmp ($baseX + 16) ($baseY + 27) 4 3 $gold
    Fill-Rect $bmp ($baseX + 9) ($baseY + 31) 5 8 $clothMid
    Fill-Rect $bmp ($baseX + 23) ($baseY + 23) 4 10 $clothDark
    Fill-Rect $bmp ($baseX + 22) ($baseY + 24) 2 6 $skin
    Fill-Rect $bmp ($baseX + 16) ($baseY + 30) 6 10 $pants
    Fill-Rect $bmp ($baseX + 25) ($baseY + 31) 5 10 $pants
    Fill-Rect $bmp ($baseX + 25 + [int]$phase.frontLeg) ($baseY + 41) 7 8 $boot
    Fill-Rect $bmp ($baseX + 13 + [int]$phase.backLeg) ($baseY + 41) 7 8 $boot
    Draw-SwordSide $bmp ($baseX + 28 + [int]$phase.swordX) ($baseY + 27) 16
    return $bmp
}

function Write-ContactSheet {
    param([array]$Entries)

    $columns = 4
    $cellWidth = 78
    $cellHeight = 86
    $rows = [int][Math]::Ceiling($Entries.Count / [double]$columns)
    $sheet = New-Object System.Drawing.Bitmap ($columns * $cellWidth), ($rows * $cellHeight), ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $graphics = [System.Drawing.Graphics]::FromImage($sheet)
    $graphics.Clear((New-Color "#1D2227"))
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half
    $font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
    $brush = New-Object System.Drawing.SolidBrush((New-Color "#E6D9BD"))

    try {
        for ($index = 0; $index -lt $Entries.Count; $index++) {
            $entry = $Entries[$index]
            $col = $index % $columns
            $row = [int][Math]::Floor($index / $columns)
            $panelX = $col * $cellWidth
            $panelY = $row * $cellHeight
            $panelBrush = New-Object System.Drawing.SolidBrush((New-Color "#37414A"))
            try {
                $graphics.FillRectangle($panelBrush, $panelX + 4, $panelY + 4, 70, 74)
            }
            finally {
                $panelBrush.Dispose()
            }

            $image = [System.Drawing.Image]::FromFile((Join-Path $PWD $entry.Path))
            try {
                $graphics.DrawImage($image, [System.Drawing.Rectangle]::new($panelX + 6, $panelY + 4, 64, 64))
            }
            finally {
                $image.Dispose()
            }

            $graphics.DrawString($entry.Label, $font, $brush, [System.Drawing.PointF]::new($panelX + 6, $panelY + 70))
        }

        $sheet.Save((Join-Path $PWD "game/art/ch01/characters/randi/hero/randi_hero_sheet.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $font.Dispose()
        $brush.Dispose()
        $graphics.Dispose()
        $sheet.Dispose()
    }
}

$entries = @()

foreach ($animationName in @("idle_down", "idle_up", "idle_side", "walk_down", "walk_up", "walk_side", "run_down", "run_up", "run_side")) {
    $parts = $animationName.Split("_")
    $mode = $parts[0]
    $direction = $parts[1]
    $frameCount = if ($mode -eq "idle") { 2 } else { 4 }

    for ($frameIndex = 0; $frameIndex -lt $frameCount; $frameIndex++) {
        $bitmap = switch ($direction) {
            "down" { Draw-RandiDownFrame $mode $frameIndex }
            "up" { Draw-RandiUpFrame $mode $frameIndex }
            "side" { Draw-RandiSideFrame $mode $frameIndex }
        }

        $relativePath = "game/art/ch01/characters/randi/hero/{0}_{1}.png" -f $animationName, $frameIndex
        try {
            Save-Sprite -Bitmap $bitmap -Path (Join-Path $PWD $relativePath)
        }
        finally {
            $bitmap.Dispose()
        }

        $entries += @{
            Label = "{0}_{1}" -f $animationName, $frameIndex
            Path = $relativePath
        }
    }
}

Write-ContactSheet -Entries $entries
Write-Output "Generated Randi hero locomotion frames."
