#Import-Module dbatools
$host.ui.rawui.BackgroundColor = "DarkGray"
Set-PSReadlineOption -TokenKind Parameter -Foregroundcolor Gray
Set-PSReadlineOption -TokenKind Operator -Foregroundcolor Gray
Set-PSReadlineOption -TokenKind String -Foregroundcolor Cyan

Import-Module posh-git

#function Prompt {
#    $Host.UI.RawUI.WindowTitle = $env:COMPUTERNAME
#    Write-Host ("[") -NoNewline
#    Write-Host ((Get-Location).Drive.Name) -NoNewline -ForegroundColor DarkGreen
#    Write-Host ("]") -NoNewline
#    Write-Host (Split-Path (Get-Location) -Leaf) -NoNewline -ForegroundColor DarkGreen
#    return "> "
#}

$GitPromptSettings.DefaultPromptPath = ''
$GitPromptSettings.DefaultPromptPrefix = ''
$GitPromptSettings.DefaultPromptSuffix = ''

function prompt {
    # Your non-prompt logic here
    $prompt += Write-Prompt "[" -ForegroundColor ([ConsoleColor]::White)
    $prompt += Write-Prompt (Get-Date -Format HH:mm:ss) -ForegroundColor ([ConsoleColor]::DarkGreen)
    $prompt += Write-Prompt "] " -ForegroundColor ([ConsoleColor]::White)
    $prompt += Write-Prompt (Split-Path (Get-Location) -Leaf) -ForegroundColor ([ConsoleColor]::Green)
    $prompt += & $GitPromptScriptBlock
    $prompt += ">"
    if ($prompt) { "$prompt " } else { " " }
}
  

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

ConvertTo-Discordian (Get-Date).DateTime
Write-Output ""