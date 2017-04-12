#Require -Version 5.0
using namespace System.Drawing

[CmdletBinding()] 
Param(
    [Parameter(Mandatory=$true)] [String] $TargetDir,
    [Parameter(Mandatory=$false)] [String] $BingCountryCode = "de-DE",
    [ValidateSet("1024x768", "1280x768", "1366x768", "1920x1080", "1920x1200")]
    [Parameter(Mandatory=$false)] [String] $Resolution = "1920x1080",
    [Parameter(Mandatory=$false)] [Int] $Max = 1,
    [Parameter(Mandatory=$false)] [Switch] $AddTitle = $false,
    [ValidateSet("Left", "Center", "Right")]
    [Parameter(Mandatory=$false)] [String] $TitleHPos = "Center",
    [ValidateSet("Top", "Middle", "Bottom")]
    [Parameter(Mandatory=$false)] [String] $TitleVPos = "Bottom",
    [Parameter(Mandatory=$false)] [Int] $TitleSize = "12",
    [Parameter(Mandatory=$false)] [String] $TitleColor = "#d8d8d8",
    [Parameter(Mandatory=$false)] [Int] $TitleMargin = 0,
    [Parameter(Mandatory=$false)] [Switch] $TitleVertical = $false
)
 
Set-StrictMode -Version latest
$ErrorAction = "Stop"

Add-Type -Assembly "System.Drawing"


$lineAlignmentH = @{
    "Top" = [StringAlignment]::Near
    "Middle" = [StringAlignment]::Center
    "Bottom" = [StringAlignment]::Far
}

$alignmentH = @{
    "Left" = [StringAlignment]::Near
    "Center" = [StringAlignment]::Center
    "Right" = [StringAlignment]::Far
}

$lineAlignmentV0 = @{
    "Left" = [StringAlignment]::Near
    "Center" = [StringAlignment]::Center
    "Right" = [StringAlignment]::Far
}

$alignmentV0 = @{
    "Top" = [StringAlignment]::Near
    "Middle" = [StringAlignment]::Center
    "Bottom" = [StringAlignment]::Far
}

$lineAlignmentV180 = @{
    "Left" = [StringAlignment]::Far
    "Center" = [StringAlignment]::Center
    "Right" = [StringAlignment]::Near
}

$alignmentV180 = @{
    "Top" = [StringAlignment]::Far
    "Middle" = [StringAlignment]::Center
    "Bottom" = [StringAlignment]::Near
}

function _Add-Title() {
    $diskImg = [Image]::fromFile($file)
    Try {
        $img = [Bitmap]::new($diskImg)
    } Finally {
        $diskImg.Dispose()
    }
    
    Try {
        $g = [Graphics]::FromImage($img)
        $g.SmoothingMode = "AntiAlias"
        
        $edgeOffset = $TitleMargin
        $textRect = [RectangleF]::new(
            $edgeOffset, $edgeOffset,
            $img.Width - 2 * $edgeOffset, $img.Height - 2 * $edgeOffset)
        $font = [Font]::new("Segoe UI Semibold", $TitleSize)
        $color = [ColorTranslator]::FromHTML($TitleColor)
        $brush = [SolidBrush]::new($color)
        $format = [StringFormat]::new()
        $format.LineAlignment = $lineAlignmentH[$TitleVPos]
        $format.Alignment = $alignmentH[$TitleHPos]
        
        If ($TitleVertical) {
            $format.FormatFlags = "DirectionVertical"
            $format.LineAlignment = $lineAlignmentV0[$TitleHPos] 
            $format.Alignment = $alignmentV0[$TitleVPos]
            
            If (-not ($TitleHPos -ieq "Left")) {
                $g.TranslateTransform($img.Width, $img.Height)
                $g.RotateTransform(180)
                
                $format.LineAlignment = $lineAlignmentV180[$TitleHPos] 
                $format.Alignment = $alignmentV180[$TitleVPos]
            }
        }
        
        $g.DrawString("$title", $font, $brush, $textRect, $format)
        
        $img.Save($file)
    } Finally {
        $img.Dispose();
    }
}

$bingResponse = Invoke-WebRequest -UseBasicParsing "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=$Max&mkt=$BingCountryCode"
$bingResponseJson = ConvertFrom-Json $bingResponse.Content
$bingResponseJson.images | %{
    $title = $_.copyright
    $fname = "$(Split-Path -Leaf $_.urlbase).jpg"
    $file = Join-Path $TargetDir $fname
    
    If (Test-Path -Type Leaf $file) {
        return
    }
    
    Invoke-WebRequest -OutFile $file "http://www.bing.com$($_.urlbase)_$Resolution.jpg"
    
    If ($AddTitle) {
        _Add-Title
    }
}