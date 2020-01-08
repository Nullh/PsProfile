#Import-Module dbatools
$host.ui.rawui.BackgroundColor = "DarkGray"
$host.ui.rawui.ForegroundColor = "Gray"


Set-PSReadLineOption -colors @{
    Command            = 'Green'
    Number             = 'Cyan'
    Member             = 'Gray'
    Operator           = 'White'
    Type               = 'Gray'
    Variable           = 'Gray'
    Parameter          = 'Gray'
    ContinuationPrompt = 'Gray'
    Default            = 'Gray'
    String             = 'Cyan'
  }


#function Prompt {
#    $Host.UI.RawUI.WindowTitle = $env:COMPUTERNAME
#    Write-Host ("[") -NoNewline
#    Write-Host ((Get-Location).Drive.Name) -NoNewline -ForegroundColor DarkGreen
#    Write-Host ("]") -NoNewline
#    Write-Host (Split-Path (Get-Location) -Leaf) -NoNewline -ForegroundColor DarkGreen
#    return "> "
#}

#$GitPromptSettings.DefaultPromptPath = ''
#$GitPromptSettings.DefaultPromptPrefix = ''
#$GitPromptSettings.DefaultPromptSuffix = ''

#function prompt {
#    # Your non-prompt logic here
#    $prompt += Write-Prompt "[" -ForegroundColor ([ConsoleColor]::White)
#    $prompt += Write-Prompt (Get-Date -Format HH:mm:ss) -ForegroundColor ([ConsoleColor]::DarkGreen)
#    $prompt += Write-Prompt "] " -ForegroundColor ([ConsoleColor]::White)
#    $prompt += Write-Prompt (Split-Path (Get-Location) -Leaf) -ForegroundColor ([ConsoleColor]::Green)
#    $prompt += & $GitPromptScriptBlock
#    $prompt += ">"
#    if ($prompt) { "$prompt " } else { " " }
#}
  

function vi ($File)
{ 
    $File = $File -replace "\\", "/" -replace " ", "\ "
    & bash.exe -c "vi $File"
}

  # ddate rubbish :)
function ConvertTo-Discordian ( [datetime]$GregorianDate )
{
$DayOfYear = $GregorianDate.DayOfYear
$Year = $GregorianDate.Year + 1166
If ( [datetime]::IsLeapYear( $GregorianDate.Year ) -and $DayOfYear -eq 60 )
    { $Day = "St. Tib's Day" }
Else
    {
    If ( [datetime]::IsLeapYear( $GregorianDate.Year ) -and $DayOfYear -gt 60 )
        { $DayOfYear-- }
    $Weekday = @( 'Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle-Prickle', 'Setting Orange' )[(($DayOfYear - 1 ) % 5 )]
    $Season  = @( 'Chaos', 'Discord', 'Confusion', 'Bureaucracy', 'The Aftermath' )[( [math]::Truncate( ( $DayOfYear - 1 ) / 73 ) )]
    $DayOfSeason = ( $DayOfYear - 1 ) % 73 + 1
    $Day = "$Weekday, $Season $DayOfSeason"
    }
$DiscordianDate = "$Day, $Year YOLD"
return $DiscordianDate
}

Import-Module posh-git

######## POSH-GIT
# with props to https://bradwilson.io/blog/prompt/powershell
# ... Import-Module for posh-git here ...

#if (-not (Get-PSDrive -Name Git -ErrorAction SilentlyContinue)) {
#    $Error.Clear()
#    $null = New-PSDrive -Name Git -PSProvider FileSystem -Root D:\Git
#}

$ShowKube = $false
$ShowAzure = $true
$ShowGit = $true
$ShowPath = $true
$ShowDate = $true
$ShowTime = $true
# Background colors

$GitPromptSettings.AfterStash.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.AfterStatus.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeIndex.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeStash.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeStatus.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchAheadStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchBehindStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchGoneStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchIdenticalStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.DefaultColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.DelimStatus.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.ErrorColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.IndexColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.LocalDefaultStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.LocalStagedStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.LocalWorkingStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.StashColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.WorkingColor.BackgroundColor = [ConsoleColor]::DarkBlue

# Foreground colors

$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::White
$GitPromptSettings.BranchGoneStatusSymbol.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchIdenticalStatusSymbol.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultColor.ForegroundColor = [ConsoleColor]::Gray
$GitPromptSettings.DelimStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.IndexColor.ForegroundColor = [ConsoleColor]::Cyan
$GitPromptSettings.WorkingColor.ForegroundColor = [ConsoleColor]::Yellow

# Prompt shape

$GitPromptSettings.AfterStatus.Text = " "
$GitPromptSettings.BeforeStatus.Text = " "
$GitPromptSettings.BranchAheadStatusSymbol.Text = "$([char]8593)"
$GitPromptSettings.BranchBehindStatusSymbol.Text = "$([char]8595)" #"↓"
$GitPromptSettings.BranchGoneStatusSymbol.Text = "x"
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.Text = "$([char]8597)"
$GitPromptSettings.BranchIdenticalStatusSymbol.Text = "$([char]8596)"
$GitPromptSettings.BranchUntrackedText = " "
$GitPromptSettings.DelimStatus.Text = " ॥"
$GitPromptSettings.LocalStagedStatusSymbol.Text = "~"
$GitPromptSettings.LocalWorkingStatusSymbol.Text = "!"

$GitPromptSettings.EnableStashStatus = $false
$GitPromptSettings.ShowStatusWhenZero = $false

######## PROMPT

set-content Function:prompt {
    if($ShowDate){
    Write-Host "$(Get-Date -Format "ddd MMM HH:mm:ss")" -ForegroundColor Yellow -BackgroundColor DarkBlue -NoNewline
    }

    # Reset the foreground color to default
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultColor.ForegroundColor

    # Write ERR for any PowerShell errors
    if ($Error.Count -ne 0) {
        Write-Host " " -NoNewLine
        Write-Host " $($Error.Count) ERR " -NoNewLine -BackgroundColor DarkRed -ForegroundColor Yellow
        # $Error.Clear()
    }

    # Write non-zero exit code from last launched process
    if ($LASTEXITCODE -ne "") {
        Write-Host " " -NoNewLine
        Write-Host " x $LASTEXITCODE " -NoNewLine -BackgroundColor DarkRed -ForegroundColor Yellow
        $LASTEXITCODE = ""
    }

    if ($ShowKube) {
        # Write the current kubectl context
        if ((Get-Command "kubectl" -ErrorAction Ignore) -ne $null) {
            $currentContext = (& kubectl config current-context 2> $null)

            Write-Host " " -NoNewLine
            Write-Host "" -NoNewLine -BackgroundColor DarkGray -ForegroundColor Green
            Write-Host " $currentContext " -NoNewLine -BackgroundColor DarkGray -ForegroundColor White
        }
    }

    if ($ShowAzure) {
        # Write the current public cloud Azure CLI subscription
        # NOTE: You will need sed from somewhere (for example, from Git for Windows)
        if (Test-Path ~/.azure/clouds.config) {
            if ((Get-Command "sed" -ErrorAction Ignore) -ne $null) {
                $currentSub = & sed -nr "/^\[AzureCloud\]/ { :l /^subscription[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ~/.azure/clouds.config
            }
            else {
                $file = Get-Content ~/.azure/clouds.config
                $currentSub = ([regex]::Matches($file, '^.*subscription\s=\s(.*)').Groups[1].Value).Trim()
            }
            if ($null -ne $currentSub) {
                $currentAccount = (Get-Content ~/.azure/azureProfile.json | ConvertFrom-Json).subscriptions | Where-Object { $_.id -eq $currentSub }
                if ($null -ne $currentAccount) {
                    Write-Host " " -NoNewLine
                    Write-Host "" -NoNewLine -BackgroundColor DarkCyan -ForegroundColor Yellow
                    $currentAccountName = ($currentAccount.Name.Split(' ') | Foreach {$_[0..5] -join '' }) -join ' '
                    Write-Host " $currentAccountName " -NoNewLine -BackgroundColor DarkCyan -ForegroundColor White
                }
            }
        }
    }

    if($ShowGit){
    # Write the current Git information
    if ((Get-Command "Get-GitDirectory" -ErrorAction Ignore) -ne $null) {
        if (Get-GitDirectory -ne $null) {
            Write-Host (Write-VcsStatus) -NoNewLine
        }
    }
    }

    if($ShowPath){
    # Write the current directory, with home folder normalized to ~
    # $currentPath = (get-location).Path.replace($home, "~")
    # $idx = $currentPath.IndexOf("::")
    # if ($idx -gt -1) { $currentPath = $currentPath.Substring($idx + 2) }
    if ($IsLinux) {
        $currentPath = $($pwd.path.Split('/')[-2..-1] -join '/')
    }
    else {
        $currentPath = $($pwd.path.Split('\')[-2..-1] -join '\')
    }


    Write-Host " " -NoNewLine
    Write-Host "" -NoNewLine -BackgroundColor DarkGreen -ForegroundColor Yellow
    Write-Host " $currentPath " -NoNewLine -BackgroundColor DarkGreen -ForegroundColor White
    }
    # Reset LASTEXITCODE so we don't show it over and over again
    $global:LASTEXITCODE = 0

    if($ShowTime){
        try
    {
        Write-Host " " -NoNewline
        $history = Get-History -ErrorAction Ignore
        if ($history)
        {
            if (([System.Management.Automation.PSTypeName]'Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty').Type)
            {
                Write-Host ([Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty]($history[-1].EndExecutionTime - $history[-1].StartExecutionTime)) -ForegroundColor DarkYellow -BackgroundColor DarkGrey -NoNewline
            }
            else
            {
                Write-Host "$([Math]::Round(($history[-1].EndExecutionTime - $history[-1].StartExecutionTime).TotalMilliseconds,2))" -ForegroundColor DarkYellow -BackgroundColor DarkGray  -NoNewline
            }
        }
        Write-Host " " -ForegroundColor DarkBlue -NoNewline
    }
    catch { }
    }
    # Write one + for each level of the pushd stack
    if ((get-location -stack).Count -gt 0) {
        Write-Host " " -NoNewLine
        Write-Host (("+" * ((get-location -stack).Count))) -NoNewLine -ForegroundColor Cyan
    }

    # Newline
    Write-Host ""

    # Determine if the user is admin, so we color the prompt green or red
    $isAdmin = $false
    $isDesktop = ($PSVersionTable.PSEdition -eq "Desktop")

    if ($isDesktop -or $IsWindows) {
        $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
        $isAdmin = $windowsPrincipal.IsInRole("Administrators") -eq 1
    }
    else {
        $isAdmin = ((& id -u) -eq 0)
    }

    if ($isAdmin) { $color = "Red"; }
    else { $color = "Green"; }

    # Write PS> for desktop PowerShell, pwsh> for PowerShell Core
    if ($isDesktop) {
        Write-Host " PS>" -NoNewLine -ForegroundColor $color
    }
    else {
        Write-Host " pwsh>" -NoNewLine -ForegroundColor $color
    }

    # Always have to return something or else we get the default prompt
    return " "
}

if ($Host.Name -eq 'Visual Studio Code Host') {
    # Place this in your VSCode profile
    Import-Module EditorServicesCommandSuite
    Import-EditorCommand -Module EditorServicesCommandSuite

}

ConvertTo-Discordian (Get-Date).DateTime