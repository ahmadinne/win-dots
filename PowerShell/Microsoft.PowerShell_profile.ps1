function Brightness ($br) {    Get-CimInstance -Namespace root/WMI -Classname WmiMonitorBrightnessMethods | Invoke-CimMethod -Methodname WmiSetBrightness -Argument @{ Timeout = 0; Brightness = $br } }


# Powershell's configurations
Invoke-Expression (&starship init powershell)
Set-PSReadlineKeyHandler -Chord Ctrl+u -Function BackwardKillLine
$EDITOR = "nvim"

# Unix like Aliases
Set-Alias -Name grep -Value Select-String
Set-Alias -Name touch -Value New-Item

# Aliases
Function Ezacmd {eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions -a}
Function Initcmd {nvim $HOME/AppData/Local/nvim/init.lua}
Function Alacrittycmd {nvim $HOME/AppData/Roaming/alacritty/alacritty.toml}
Set-Alias -Name ls -Value Ezacmd
Set-Alias -Name vi -Value $EDITOR
Set-Alias -Name init.lua -Value Initcmd
Set-Alias -Name alacritty.toml -Value Alacrittycmd

Function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}
