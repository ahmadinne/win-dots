function Brightness ($br) {    Get-CimInstance -Namespace root/WMI -Classname WmiMonitorBrightnessMethods | Invoke-CimMethod -Methodname WmiSetBrightness -Argument @{ Timeout = 0; Brightness = $br } }


# Powershell's configurations
Invoke-Expression (&starship init powershell)
Set-PSReadlineKeyHandler -Chord Ctrl+u -Function BackwardKillLine
Set-PSReadLineKeyHandler -Chord Escape -Function Abort
$EDITOR = "nvim"

# Source
. "$PSScriptRoot\pacman.ps1"

# Unix like Aliases
Set-Alias -Name grep -Value Select-String
Set-Alias -Name touch -Value New-Item

# Aliases
Function Startupcmd {cd "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/"; explorer .}
Function Initcmd {nvim $HOME/AppData/Local/nvim/init.lua}
Function Alacrittycmd {nvim $HOME/AppData/Roaming/alacritty/alacritty.toml}
Function Terminalcmd {nvim $HOME/scoop/apps/windows-terminal/current/settings/settings.json}
Function Fetches {cls; bunnyfetch}
Function ComMojang {cd "C:\Users\ahmadinne\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang" }
# Set-Alias -Name ls -Value Ezacmd
Set-Alias -Name vi -Value $EDITOR
Set-Alias -Name init.lua -Value Initcmd
Set-Alias -Name alacritty.toml -Value Alacrittycmd
Set-Alias -Name settings.json -Value Terminalcmd
Set-Alias -Name com.mojang -Value ComMojang
Set-Alias -Name autorun -Value taskschd.msc
Set-Alias -Name autostart -Value taskschd.msc
Set-Alias -Name startup -Value taskschd.msc
Set-Alias -Name shell:startup -Value Startupcmd
Set-Alias -Name bf -Value bunnyfetch
Set-Alias -Name bfs -Value Fetches

Function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

Set-Alias originalCd Set-Location
Remove-Item Alias:cd -Force 
Function cd {
	param([string]$path = $HOME)
	Set-Location $path
}

Set-Alias originalLs Get-ChildItem
Remove-Item Alias:ls -Force
Function ls { eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions }
Function lsa { eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions -a }

# Starto
bunnyfetch
