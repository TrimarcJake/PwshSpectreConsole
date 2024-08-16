#
# Module manifest for module 'PwshSpectreConsole'
#
# Generated by: Shaun Lawrie
#
# Generated on: 07/23/2024
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PwshSpectreConsole'

# Version number of this module.
ModuleVersion = '1.12.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '8c5ca00d-7f0f-4179-98bf-bdaebceaebc0'

# Author of this module
Author = 'Shaun Lawrie'

# Company or vendor of this module
CompanyName = 'Shaun Lawrie'

# Copyright statement for this module
Copyright = '(c) Shaun Lawrie. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A convenient PowerShell wrapper for Spectre.Console'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = '.\packages\Spectre.Console\lib\net6.0\Spectre.Console.dll', 
               '.\packages\Spectre.Console.ImageSharp\lib\net6.0\Spectre.Console.ImageSharp.dll', 
               '.\packages\SixLabors.ImageSharp\lib\net6.0\SixLabors.ImageSharp.dll', 
               '.\packages\Spectre.Console.Json\lib\net6.0\Spectre.Console.Json.dll', 
               '.\packages\PwshSpectreConsole.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'PwshSpectreConsole.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Add-SpectreJob', 'Format-SpectreBarChart', 
               'Format-SpectreBreakdownChart', 'Format-SpectrePanel', 
               'Format-SpectreTable', 'Format-SpectreTree', 'Get-SpectreEscapedText', 
               'Get-SpectreImage', 'Get-SpectreImageExperimental', 
               'Invoke-SpectreCommandWithProgress', 
               'Invoke-SpectreCommandWithStatus', 'Read-SpectreMultiSelection', 
               'Read-SpectreMultiSelectionGrouped', 'Read-SpectrePause', 
               'Read-SpectreSelection', 'Read-SpectreText', 'Set-SpectreColors', 
               'Start-SpectreDemo', 'Wait-SpectreJobs', 'Write-SpectreFigletText', 
               'Write-SpectreHost', 'Write-SpectreRule', 'Read-SpectreConfirm', 
               'New-SpectreChartItem', 'Invoke-SpectreScriptBlockQuietly', 
               'Get-SpectreDemoColors', 'Get-SpectreDemoEmoji', 'Format-SpectreJson', 
               'Write-SpectreCalendar', 'Start-SpectreRecording', 'Stop-SpectreRecording', 
               'Format-SpectreColumns', 'Format-SpectreRows', 'Format-SpectrePadded',
               'Format-SpectreGrid', 'New-SpectreGridRow', 'Format-SpectreTextPath',
               'New-SpectreLayout', 'Format-SpectreAligned', 'Out-SpectreHost'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'fst', 'fsj'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Windows','Linux'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/ShaunLawrie/PwshSpectreConsole/blob/main/LICENSE.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/ShaunLawrie/PwshSpectreConsole'

        # A URL to an icon representing this module.
        IconUri = 'https://shaunlawrie.com/images/pwshspectreconsole.png'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

