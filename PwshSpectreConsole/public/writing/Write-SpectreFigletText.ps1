using module "..\..\private\attributes\ColorAttributes.psm1"

function Write-SpectreFigletText {
    <#
    .SYNOPSIS
    Writes a Spectre Console Figlet text to the console.

    .DESCRIPTION
    This function writes a Spectre Console Figlet text to the console. The text can be aligned to the left, right, or centered, and can be displayed in a specified color.

    .PARAMETER Text
    The text to display in the Figlet format.

    .PARAMETER Alignment
    The alignment of the text. Valid values are "Left", "Right", and "Centered". The default value is "Left".

    .PARAMETER Color
    The color of the text. The default value is the accent color of the script.

    .EXAMPLE
    # Displays the text "Hello Spectre!" in the center of the console, in red color.
    Write-SpectreFigletText -Text "Hello Spectre!" -Alignment "Centered" -Color "Red"
    #>
    [Reflection.AssemblyMetadata("title", "Write-SpectreFigletText")]
    param (
        [string] $Text = "Hello Spectre!",
        [ValidateSet("Left", "Right", "Center")]
        [string] $Alignment = "Left",
        [ValidateSpectreColor()]
        [ArgumentCompletionsSpectreColors()]
        [string] $Color = $script:AccentColor.ToMarkup()
    )
    $figletText = [Spectre.Console.FigletText]::new($Text)
    $figletText.Justification = [Spectre.Console.Justify]::$Alignment
    $figletText.Color = ($Color | Convert-ToSpectreColor)
    Write-AnsiConsole $figletText
}