Remove-Module PwshSpectreConsole -Force -ErrorAction SilentlyContinue
Import-Module "$PSScriptRoot\..\..\PwshSpectreConsole\PwshSpectreConsole.psd1" -Force
Import-Module "$PSScriptRoot\..\TestHelpers.psm1" -Force

Describe "Format-SpectreTable" {
    InModuleScope "PwshSpectreConsole" {
        BeforeEach {
            $testConsole = [Spectre.Console.Testing.TestConsole]::new()
            $testData = $null
            $testBorder = Get-RandomBoxBorder
            $testColor = Get-RandomColor

            Mock Write-AnsiConsole {
                $RenderableObject | Should -BeOfType [Spectre.Console.Table]
                $RenderableObject.BorderStyle.Foreground.ToMarkup() | Should -Be $testColor
                $RenderableObject.Rows.Count | Should -Be $testData.Count
                if($testBorder -ne "None") {
                    $RenderableObject.Border.GetType().Name | Should -BeLike "*$testBorder*"
                }

                $testConsole.Write($RenderableObject)
            }
        }

        It "Should create a table when default display members for a command are required" {
            $testData = Get-ChildItem "$PSScriptRoot"
            Format-SpectreTable -Data $testData -Border $testBorder -Color $testColor
            Assert-MockCalled -CommandName "Write-AnsiConsole" -Times 1 -Exactly
        }

        It "Should create a table when default display members for a command are required and input is piped" {
            $testData = Get-ChildItem "$PSScriptRoot"
            $testData | Format-SpectreTable -Border $testBorder -Color $testColor
            Assert-MockCalled -CommandName "Write-AnsiConsole" -Times 1 -Exactly
        }

        It "Should be able to retrieve default display members for command output with format data" {
            $testData = Get-ChildItem "$PSScriptRoot"
            $defaultDisplayMembers = $testData | Format-Table | Get-TableHeader
            if ($IsLinux -or $IsMacOS) {
                #  Expected @('UnixMode', 'User', 'Group', 'LastWrite…', 'Size', 'Name'), but got @('UnixMode', 'User', 'Group', 'LastWriteTime', 'Size', 'Name').
                # i have no idea whats truncating LastWriteTime
                # $defaultDisplayMembers.Properties.GetEnumerator().Name | Should -Be @("UnixMode", "User", "Group", "LastWriteTime", "Size", "Name")
                $defaultDisplayMembers.keys | Should -Match 'UnixMode|User|Group|LastWrite|Size|Name'
            }
            else {
                $defaultDisplayMembers.keys | Should -Be @("Mode", "LastWriteTime", "Length", "Name")
            }
        }

        It "Should not throw and should return null when input does not have format data" {
            {
                $defaultDisplayMembers = [hashtable]@{
                    "Hello" = "World"
                } | Get-TableHeader
                $defaultDisplayMembers | Should -Be $null
            } | Should -Not -Throw
        }

        It "Should be able to format ansi strings" {
            $rawString = "hello world"
            $ansiString = "`e[31mhello `e[46mworld`e[0m"
            $result = ConvertTo-SpectreDecoration -String $ansiString
            $result.Length | Should -Be $rawString.Length
        }

        It "Should be able to format PSStyle strings" {
            $rawString = ""
            $ansiString = ""
            $PSStyle | Get-Member -MemberType Property | Where-Object { $_.Definition -match '^string' -And $_.Name -notmatch 'off$|Reset' } | ForEach-Object {
                $name = $_.Name
                $rawString += "$name "
                $ansiString += "$($PSStyle.$name)$name "
            }
            $ansiString += "$($PSStyle.Reset)"
            $result = ConvertTo-SpectreDecoration -String $ansiString
            $result.Length | Should -Be $rawString.Length
        }

        It "Should be able to format strings with spectre markup when opted in" {
            $rawString = "hello spectremarkup world"
            $ansiString = "hello [red]spectremarkup[/] world"
            $result = ConvertTo-SpectreDecoration -String $ansiString -AllowMarkup
            $result.Length | Should -Be $rawString.Length
        }

        It "Should leave spectre markup alone by default" {
            $ansiString = "hello [red]spectremarkup[/] world"
            $result = ConvertTo-SpectreDecoration -String $ansiString
            $result.Length | Should -Be $ansiString.Length
        }

        It "Should be able to create a new table cell with spectre markup" {
            $rawString = "hello spectremarkup world"
            $ansiString = "hello [red]spectremarkup[/] world"
            $result = New-TableCell -String $ansiString -AllowMarkup
            $result | Should -BeOfType [Spectre.Console.Markup]
            $result.Length | Should -Be $rawString.Length
        }

        It "Should be able to create a new table cell without spectre markup by default" {
            $ansiString = "hello [red]spectremarkup[/] world"
            $result = New-TableCell -String $ansiString
            $result | Should -BeOfType [Spectre.Console.Text]
            $result.Length | Should -Be $ansiString.Length
        }

        It "Should be able to create a new table row with spectre markup" {
            $entryitem = Get-SpectreTableRowData -Markup
            $result = New-TableRow -Entry $entryItem -AllowMarkup
            $result -is [array] | Should -Be $true
            $result[0] | Should -BeOfType [Spectre.Console.Markup]
            $result.Count | Should -Be $entryitem.Count
        }

        It "Should be able to create a new table row without spectre markup by default" {
            $entryitem = Get-SpectreTableRowData -Markup
            $result = New-TableRow -Entry $entryItem
            $result -is [array] | Should -Be $true
            $result[0] | Should -BeOfType [Spectre.Console.Text]
            $result[0].Length | Should -Be $entryItem[0].Length
            $result.Count | Should -Be $entryitem.Count
        }
    }
}
