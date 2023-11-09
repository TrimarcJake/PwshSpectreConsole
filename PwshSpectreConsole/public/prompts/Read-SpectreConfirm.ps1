using module "..\..\private\attributes\ColorAttributes.psm1"

function Read-SpectreConfirm {
    <#
    .SYNOPSIS
    Displays a simple confirmation prompt with the option of selecting yes or no and returns a boolean representing the answer. 

    .DESCRIPTION
    Displays a simple confirmation prompt with the option of selecting yes or no. Additional options are provided to display either a success or failure response message in addition to the boolean return value.

    .PARAMETER Prompt
    The prompt to display to the user. The default value is "Do you like cute animals?".

    .PARAMETER DefaultAnswer
    The default answer to the prompt if the user just presses enter. The default value is "y".

    .PARAMETER ConfirmSuccess
    The text and markup to display if the user chooses yes. If left undefined, nothing will display.

    .PARAMETER ConfirmFailure
    The text and markup to display if the user chooses no. If left undefined, nothing will display.

    .EXAMPLE
    # This example displays a simple prompt. The user can select either yes or no [Y/n]. A different message is displayed based on the user's selection. The prompt uses the AnsiConsole.MarkupLine convenience method to support colored text and other supported markup. 
    $readSpectreConfirmSplat = @{
        Prompt = "Would you like to continue the preview installation of [#7693FF]PowerShell 7?[/]"
        ConfirmSuccess = "Woohoo! The internet awaits your elite development contributions."
        ConfirmFailure = "What kind of monster are you? How could you do this?"
    }
    Read-SpectreConfirm @readSpectreConfirmSplat
    #>
    [Reflection.AssemblyMetadata("title", "Read-SpectreConfirm")]
    param (
        [String] $Prompt = "Do you like cute animals?",
        [ValidateSet("y", "n")]
        [string] $DefaultAnswer = "y",
        [string] $ConfirmSuccess,
        [string] $ConfirmFailure,
        [ValidateSpectreColor()]
        [ArgumentCompletionsSpectreColors()]
        [string] $Color = $script:AccentColor.ToMarkup()
    )

    # This is much fiddlier but it exposes the ability to set the color scheme. The confirmationprompt is just a textprompt with two choices hard coded to y/n:
    # https://github.com/spectreconsole/spectre.console/blob/63b940cf0eb127a8cd891a4fe338aa5892d502c5/src/Spectre.Console/Prompts/ConfirmationPrompt.cs#L71
    $confirmationPrompt = [Spectre.Console.TextPrompt[string]]::new($Prompt)
    $confirmationPrompt = [Spectre.Console.TextPromptExtensions]::DefaultValue($confirmationPrompt, $DefaultAnswer)
    $confirmationPrompt = [Spectre.Console.TextPromptExtensions]::AddChoice($confirmationPrompt, "y")
    $confirmationPrompt = [Spectre.Console.TextPromptExtensions]::AddChoice($confirmationPrompt, "n")

    # This is how I added the default colors with Set-SpectreColors so you don't have to keep passing them through and get a consistent TUI color scheme
    $confirmationPrompt.DefaultValueStyle = [Spectre.Console.Style]::new($script:DefaultValueColor)
    $confirmationPrompt.ChoicesStyle = [Spectre.Console.Style]::new(($Color | Convert-ToSpectreColor))
    $confirmationPrompt.InvalidChoiceMessage = "[red]Please select one of the available options[/]"

    # Invoke-SpectrePromptAsync supports ctrl-c
    $sprompt = (Invoke-SpectrePromptAsync -Prompt $confirmationPrompt) -eq "y"

    if(!$sprompt){
        if(![String]::IsNullOrWhiteSpace($ConfirmFailure)){
            [Spectre.Console.AnsiConsole]::MarkupLine($ConfirmFailure)
        }
    }else{
        if(![String]::IsNullOrWhiteSpace($ConfirmSuccess)){
            [Spectre.Console.AnsiConsole]::MarkupLine($ConfirmSuccess)
        }
    }

    return $sprompt
}