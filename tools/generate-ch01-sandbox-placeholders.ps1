Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

function New-Color {
    param(
        [Parameter(Mandatory = $true)][string]$Hex,
        [int]$Alpha = 255
    )

    $clean = $Hex.TrimStart("#")
    if ($clean.Length -ne 6) {
        throw "Expected 6-digit hex color, got '$Hex'."
    }

    $r = [Convert]::ToInt32($clean.Substring(0, 2), 16)
    $g = [Convert]::ToInt32($clean.Substring(2, 2), 16)
    $b = [Convert]::ToInt32($clean.Substring(4, 2), 16)
    return [System.Drawing.Color]::FromArgb($Alpha, $r, $g, $b)
}

function Set-PixelSafe {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Bitmap,
        [int]$X,
        [int]$Y,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Color
    )

    if ($X -lt 0 -or $Y -lt 0 -or $X -ge $Bitmap.Width -or $Y -ge $Bitmap.Height) {
        return
    }
    $Bitmap.SetPixel($X, $Y, $Color)
}

function Fill-Rect {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Bitmap,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Color
    )

    for ($yy = $Y; $yy -lt ($Y + $Height); $yy++) {
        for ($xx = $X; $xx -lt ($X + $Width); $xx++) {
            Set-PixelSafe -Bitmap $Bitmap -X $xx -Y $yy -Color $Color
        }
    }
}

function Fill-Circle {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Bitmap,
        [int]$CenterX,
        [int]$CenterY,
        [int]$Radius,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Color
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

function Stroke-Circle {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Bitmap,
        [int]$CenterX,
        [int]$CenterY,
        [int]$Radius,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Color
    )

    for ($yy = ($CenterY - $Radius - 1); $yy -le ($CenterY + $Radius + 1); $yy++) {
        for ($xx = ($CenterX - $Radius - 1); $xx -le ($CenterX + $Radius + 1); $xx++) {
            $dx = $xx - $CenterX
            $dy = $yy - $CenterY
            $distanceSquared = ($dx * $dx) + ($dy * $dy)
            if ($distanceSquared -le ($Radius * $Radius) -and $distanceSquared -ge (($Radius - 1) * ($Radius - 1))) {
                Set-PixelSafe -Bitmap $Bitmap -X $xx -Y $yy -Color $Color
            }
        }
    }
}

function Outline-Rect {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Bitmap,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [Parameter(Mandatory = $true)][System.Drawing.Color]$Color
    )

    Fill-Rect -Bitmap $Bitmap -X $X -Y $Y -Width $Width -Height 1 -Color $Color
    Fill-Rect -Bitmap $Bitmap -X $X -Y ($Y + $Height - 1) -Width $Width -Height 1 -Color $Color
    Fill-Rect -Bitmap $Bitmap -X $X -Y $Y -Width 1 -Height $Height -Color $Color
    Fill-Rect -Bitmap $Bitmap -X ($X + $Width - 1) -Y $Y -Width 1 -Height $Height -Color $Color
}

function New-SpriteBitmap {
    $bitmap = New-Object System.Drawing.Bitmap 32, 32, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    for ($yy = 0; $yy -lt 32; $yy++) {
        for ($xx = 0; $xx -lt 32; $xx++) {
            $bitmap.SetPixel($xx, $yy, [System.Drawing.Color]::Transparent)
        }
    }
    return $bitmap
}

function Save-Sprite {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Bitmap]$Bitmap,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }
    $Bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
}

function Write-ContactSheet {
    param(
        [Parameter(Mandatory = $true)][array]$Targets
    )

    $sheetWidth = 356
    $sheetHeight = 104
    $sheet = New-Object System.Drawing.Bitmap $sheetWidth, $sheetHeight, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $graphics = [System.Drawing.Graphics]::FromImage($sheet)
    $graphics.Clear((New-Color "#1D2227"))
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half

    $font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
    $brush = New-Object System.Drawing.SolidBrush((New-Color "#E6D9BD"))

    try {
        for ($index = 0; $index -lt $Targets.Count; $index++) {
            $target = $Targets[$index]
            $sourcePath = Join-Path $PWD $target.Path
            $bmp = [System.Drawing.Image]::FromFile($sourcePath)
            try {
                $panelX = 8 + ($index * 68)
                $panelY = 8
                $panelBrush = New-Object System.Drawing.SolidBrush((New-Color "#37414A"))
                try {
                    $graphics.FillRectangle($panelBrush, $panelX, $panelY, 60, 88)
                }
                finally {
                    $panelBrush.Dispose()
                }

                $graphics.DrawImage($bmp, [System.Drawing.Rectangle]::new($panelX + 6, $panelY + 6, 48, 48))
                $graphics.DrawString($target.Label, $font, $brush, [System.Drawing.PointF]::new($panelX + 4, $panelY + 60))
            }
            finally {
                $bmp.Dispose()
            }
        }

        $sheetPath = Join-Path $PWD "game/art/ch01/characters/sandbox_placeholder_sheet.png"
        $sheet.Save($sheetPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $font.Dispose()
        $brush.Dispose()
        $graphics.Dispose()
        $sheet.Dispose()
    }
}

function Draw-Randi {
    $bmp = New-SpriteBitmap
    $outline = New-Color "#2E2A25"
    $skin = New-Color "#E3BD8B"
    $hairDark = New-Color "#A87820"
    $hairMid = New-Color "#E4BD48"
    $hairLight = New-Color "#F6DE82"
    $hoodDark = New-Color "#41602E"
    $hoodMid = New-Color "#5F883C"
    $hoodLight = New-Color "#7AA348"
    $capeDark = New-Color "#355027"
    $capeMid = New-Color "#4B6A33"
    $cloth = New-Color "#91695B"
    $pants = New-Color "#5C5244"
    $boots = New-Color "#2E2A25"
    $metal = New-Color "#BCC2BE"
    $strap = New-Color "#8D6E45"

    Fill-Rect -Bitmap $bmp -X 13 -Y 6 -Width 6 -Height 6 -Color $skin
    Fill-Rect -Bitmap $bmp -X 11 -Y 4 -Width 10 -Height 4 -Color $hairDark
    Fill-Rect -Bitmap $bmp -X 12 -Y 4 -Width 8 -Height 3 -Color $hairMid
    Fill-Rect -Bitmap $bmp -X 13 -Y 4 -Width 6 -Height 2 -Color $hairLight
    Fill-Rect -Bitmap $bmp -X 11 -Y 8 -Width 2 -Height 3 -Color $hairMid
    Fill-Rect -Bitmap $bmp -X 19 -Y 8 -Width 2 -Height 3 -Color $hairMid
    Fill-Rect -Bitmap $bmp -X 10 -Y 9 -Width 1 -Height 2 -Color $skin
    Fill-Rect -Bitmap $bmp -X 21 -Y 9 -Width 1 -Height 2 -Color $skin

    Fill-Rect -Bitmap $bmp -X 10 -Y 11 -Width 12 -Height 3 -Color $hoodDark
    Fill-Rect -Bitmap $bmp -X 11 -Y 12 -Width 10 -Height 6 -Color $hoodMid
    Fill-Rect -Bitmap $bmp -X 12 -Y 13 -Width 8 -Height 2 -Color $hoodLight
    Fill-Rect -Bitmap $bmp -X 9 -Y 13 -Width 2 -Height 6 -Color $capeMid
    Fill-Rect -Bitmap $bmp -X 10 -Y 15 -Width 1 -Height 3 -Color $capeDark
    Fill-Rect -Bitmap $bmp -X 12 -Y 18 -Width 2 -Height 5 -Color $cloth
    Fill-Rect -Bitmap $bmp -X 14 -Y 17 -Width 1 -Height 6 -Color $strap
    Fill-Rect -Bitmap $bmp -X 15 -Y 16 -Width 1 -Height 4 -Color $strap
    Fill-Rect -Bitmap $bmp -X 16 -Y 16 -Width 3 -Height 2 -Color $strap
    Fill-Rect -Bitmap $bmp -X 20 -Y 14 -Width 2 -Height 5 -Color $cloth
    Fill-Rect -Bitmap $bmp -X 21 -Y 15 -Width 1 -Height 2 -Color $skin
    Fill-Rect -Bitmap $bmp -X 12 -Y 23 -Width 3 -Height 3 -Color $pants
    Fill-Rect -Bitmap $bmp -X 17 -Y 23 -Width 3 -Height 3 -Color $pants
    Fill-Rect -Bitmap $bmp -X 11 -Y 26 -Width 4 -Height 2 -Color $boots
    Fill-Rect -Bitmap $bmp -X 17 -Y 26 -Width 4 -Height 2 -Color $boots
    Fill-Rect -Bitmap $bmp -X 22 -Y 14 -Width 1 -Height 10 -Color $metal
    Fill-Rect -Bitmap $bmp -X 21 -Y 22 -Width 3 -Height 2 -Color $strap
    Fill-Rect -Bitmap $bmp -X 13 -Y 9 -Width 1 -Height 1 -Color $outline
    Fill-Rect -Bitmap $bmp -X 18 -Y 9 -Width 1 -Height 1 -Color $outline
    Fill-Rect -Bitmap $bmp -X 15 -Y 10 -Width 2 -Height 1 -Color $outline
    Outline-Rect -Bitmap $bmp -X 11 -Y 4 -Width 10 -Height 24 -Color $outline
    Set-PixelSafe -Bitmap $bmp -X 10 -Y 10 -Color $outline
    Set-PixelSafe -Bitmap $bmp -X 21 -Y 10 -Color $outline
    return $bmp
}

function Draw-PotosVillager {
    $bmp = New-SpriteBitmap
    $outline = New-Color "#2D2824"
    $skin = New-Color "#D5B182"
    $hair = New-Color "#5A4736"
    $shawl = New-Color "#7A614A"
    $apron = New-Color "#CAB89A"
    $rope = New-Color "#8E7650"
    $moss = New-Color "#647056"
    $ward = New-Color "#86A9A0"

    Fill-Rect -Bitmap $bmp -X 13 -Y 5 -Width 6 -Height 6 -Color $skin
    Fill-Rect -Bitmap $bmp -X 12 -Y 4 -Width 8 -Height 3 -Color $hair
    Fill-Rect -Bitmap $bmp -X 10 -Y 10 -Width 11 -Height 10 -Color $shawl
    Fill-Rect -Bitmap $bmp -X 10 -Y 13 -Width 2 -Height 6 -Color $shawl
    Fill-Rect -Bitmap $bmp -X 13 -Y 12 -Width 5 -Height 8 -Color $apron
    Fill-Rect -Bitmap $bmp -X 12 -Y 16 -Width 7 -Height 1 -Color $rope
    Fill-Rect -Bitmap $bmp -X 14 -Y 20 -Width 3 -Height 5 -Color $moss
    Fill-Rect -Bitmap $bmp -X 17 -Y 20 -Width 3 -Height 5 -Color $moss
    Fill-Rect -Bitmap $bmp -X 14 -Y 25 -Width 3 -Height 2 -Color $outline
    Fill-Rect -Bitmap $bmp -X 17 -Y 25 -Width 3 -Height 2 -Color $outline
    Fill-Rect -Bitmap $bmp -X 9 -Y 14 -Width 2 -Height 3 -Color $ward
    Fill-Rect -Bitmap $bmp -X 9 -Y 17 -Width 1 -Height 2 -Color $rope
    Outline-Rect -Bitmap $bmp -X 10 -Y 4 -Width 11 -Height 23 -Color $outline
    Fill-Rect -Bitmap $bmp -X 15 -Y 8 -Width 1 -Height 1 -Color $outline
    Fill-Rect -Bitmap $bmp -X 17 -Y 8 -Width 1 -Height 1 -Color $outline
    return $bmp
}

function Draw-WaterPalaceAttendant {
    $bmp = New-SpriteBitmap
    $outline = New-Color "#25303B"
    $skin = New-Color "#DEC4A1"
    $hair = New-Color "#607B86"
    $robe = New-Color "#E7E1D2"
    $sash = New-Color "#69A7AF"
    $trim = New-Color "#C7B277"
    $shade = New-Color "#B5C6CA"

    Fill-Rect -Bitmap $bmp -X 13 -Y 5 -Width 6 -Height 6 -Color $skin
    Fill-Rect -Bitmap $bmp -X 12 -Y 4 -Width 8 -Height 2 -Color $hair
    Fill-Rect -Bitmap $bmp -X 11 -Y 10 -Width 10 -Height 12 -Color $robe
    Fill-Rect -Bitmap $bmp -X 14 -Y 11 -Width 4 -Height 10 -Color $sash
    Fill-Rect -Bitmap $bmp -X 10 -Y 20 -Width 12 -Height 5 -Color $robe
    Fill-Rect -Bitmap $bmp -X 10 -Y 24 -Width 12 -Height 2 -Color $shade
    Fill-Rect -Bitmap $bmp -X 10 -Y 25 -Width 12 -Height 1 -Color $trim
    Fill-Rect -Bitmap $bmp -X 11 -Y 26 -Width 4 -Height 1 -Color $trim
    Fill-Rect -Bitmap $bmp -X 17 -Y 26 -Width 4 -Height 1 -Color $trim
    Outline-Rect -Bitmap $bmp -X 10 -Y 4 -Width 12 -Height 23 -Color $outline
    Fill-Rect -Bitmap $bmp -X 15 -Y 8 -Width 1 -Height 1 -Color $outline
    Fill-Rect -Bitmap $bmp -X 17 -Y 8 -Width 1 -Height 1 -Color $outline
    return $bmp
}

function Draw-PandoraRefugee {
    $bmp = New-SpriteBitmap
    $outline = New-Color "#302824"
    $skin = New-Color "#D4B18A"
    $hair = New-Color "#4A3A33"
    $cloth = New-Color "#8E615E"
    $patch = New-Color "#D8C7AE"
    $bundle = New-Color "#7A5A43"
    $pants = New-Color "#5F524B"
    $sash = New-Color "#B58763"

    Fill-Rect -Bitmap $bmp -X 12 -Y 6 -Width 6 -Height 6 -Color $skin
    Fill-Rect -Bitmap $bmp -X 11 -Y 5 -Width 8 -Height 2 -Color $hair
    Fill-Rect -Bitmap $bmp -X 18 -Y 7 -Width 6 -Height 6 -Color $bundle
    Fill-Rect -Bitmap $bmp -X 10 -Y 11 -Width 10 -Height 10 -Color $cloth
    Fill-Rect -Bitmap $bmp -X 11 -Y 13 -Width 2 -Height 7 -Color $cloth
    Fill-Rect -Bitmap $bmp -X 16 -Y 13 -Width 3 -Height 3 -Color $patch
    Fill-Rect -Bitmap $bmp -X 13 -Y 16 -Width 6 -Height 1 -Color $sash
    Fill-Rect -Bitmap $bmp -X 12 -Y 20 -Width 3 -Height 5 -Color $pants
    Fill-Rect -Bitmap $bmp -X 16 -Y 20 -Width 3 -Height 5 -Color $pants
    Fill-Rect -Bitmap $bmp -X 12 -Y 25 -Width 3 -Height 2 -Color $outline
    Fill-Rect -Bitmap $bmp -X 16 -Y 25 -Width 3 -Height 2 -Color $outline
    Outline-Rect -Bitmap $bmp -X 10 -Y 5 -Width 14 -Height 22 -Color $outline
    Fill-Rect -Bitmap $bmp -X 14 -Y 9 -Width 1 -Height 1 -Color $outline
    Fill-Rect -Bitmap $bmp -X 16 -Y 9 -Width 1 -Height 1 -Color $outline
    return $bmp
}

function Draw-RabiteEcho {
    $bmp = New-SpriteBitmap
    $outline = New-Color "#5C4338"
    $body = New-Color "#F2DFC5"
    $belly = New-Color "#F7E8D8"
    $ear = New-Color "#C98378"
    $cheek = New-Color "#DF9D8E"
    $eye = New-Color "#3B2E2B"
    $accent = New-Color "#78A6C5"

    Fill-Circle -Bitmap $bmp -CenterX 16 -CenterY 18 -Radius 8 -Color $body
    Fill-Circle -Bitmap $bmp -CenterX 16 -CenterY 19 -Radius 5 -Color $belly
    Fill-Circle -Bitmap $bmp -CenterX 11 -CenterY 10 -Radius 3 -Color $body
    Fill-Circle -Bitmap $bmp -CenterX 21 -CenterY 10 -Radius 3 -Color $body
    Fill-Rect -Bitmap $bmp -X 10 -Y 8 -Width 3 -Height 2 -Color $ear
    Fill-Rect -Bitmap $bmp -X 20 -Y 8 -Width 3 -Height 2 -Color $ear
    Fill-Rect -Bitmap $bmp -X 12 -Y 18 -Width 1 -Height 1 -Color $eye
    Fill-Rect -Bitmap $bmp -X 19 -Y 18 -Width 1 -Height 1 -Color $eye
    Fill-Rect -Bitmap $bmp -X 15 -Y 20 -Width 2 -Height 1 -Color $eye
    Fill-Rect -Bitmap $bmp -X 11 -Y 21 -Width 2 -Height 1 -Color $cheek
    Fill-Rect -Bitmap $bmp -X 20 -Y 21 -Width 2 -Height 1 -Color $cheek
    Fill-Rect -Bitmap $bmp -X 14 -Y 11 -Width 4 -Height 2 -Color $accent
    Stroke-Circle -Bitmap $bmp -CenterX 16 -CenterY 18 -Radius 8 -Color $outline
    Stroke-Circle -Bitmap $bmp -CenterX 11 -CenterY 10 -Radius 3 -Color $outline
    Stroke-Circle -Bitmap $bmp -CenterX 21 -CenterY 10 -Radius 3 -Color $outline
    Fill-Rect -Bitmap $bmp -X 12 -Y 26 -Width 3 -Height 1 -Color $outline
    Fill-Rect -Bitmap $bmp -X 17 -Y 26 -Width 3 -Height 1 -Color $outline
    return $bmp
}

function Write-PlaceholderSprites {
    $targets = @(
        @{ Label = "Randi"; Path = "game/art/ch01/characters/randi/sandbox_placeholder.png"; Drawer = ${function:Draw-Randi} },
        @{ Label = "Villager"; Path = "game/art/ch01/characters/potos_villager/sandbox_placeholder.png"; Drawer = ${function:Draw-PotosVillager} },
        @{ Label = "Attendant"; Path = "game/art/ch01/characters/water_palace_attendant/sandbox_placeholder.png"; Drawer = ${function:Draw-WaterPalaceAttendant} },
        @{ Label = "Refugee"; Path = "game/art/ch01/characters/pandora_refugee/sandbox_placeholder.png"; Drawer = ${function:Draw-PandoraRefugee} },
        @{ Label = "Rabite"; Path = "game/art/ch01/characters/rabite_echo/sandbox_placeholder.png"; Drawer = ${function:Draw-RabiteEcho} }
    )

    foreach ($target in $targets) {
        $bitmap = & $target.Drawer
        try {
            Save-Sprite -Bitmap $bitmap -Path (Join-Path $PWD $target.Path)
        }
        finally {
            $bitmap.Dispose()
        }
    }

    Write-ContactSheet -Targets $targets
}

Write-PlaceholderSprites
Write-Output "Generated Chapter 1 sandbox placeholder sprites."
