# Powershell's configurations
Import-Module -Name Terminal-Icons
$EDITOR = "nvim"
# Set-PSReadLineOption -EditMode Vi #gabisa set-psread kalo ini nyala
# Set-PSReadLineOption -ViModeIndicator Cursor #sama aja
Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardKillWord
Set-PSReadlineKeyHandler -Chord Ctrl+u -Function BackwardKillLine
Set-PSReadLineKeyHandler -Chord Escape -Function Abort
Remove-PSReadLineKeyHandler -Chord Ctrl+Spacebar

# Unix like Aliases
Set-Alias -Name grep -Value Select-String
Set-Alias -Name touch -Value New-Item

# Aliases
Function Startupcmd {cd "$env:USERPROFILE/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/"; explorer .}
Function Initcmd {nvim $env:USERPROFILE/AppData/Local/nvim/init.lua}
Function Alacrittycmd {nvim $env:USERPROFILE/AppData/Roaming/alacritty/alacritty.toml}
Function Terminalcmd {nvim "$env:USERPROFILE/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"}
Function Fetches {cls; bunnyfetch}
Function ComMojang {cd "$env:USERPROFILE\AppData\Roaming\Minecraft Bedrock\Users\Shared\games\com.mojang" }
Function behaviorCmd {cd "$env:USERPROFILE\AppData\Roaming\Minecraft Bedrock\Users\Shared\games\com.mojang\development_behavior_packs" }
Function resourceCmd {cd "$env:USERPROFILE\AppData\Roaming\Minecraft Bedrock\Users\Shared\games\com.mojang\development_resource_packs" }
Function HostsCmd {nvim "C:\Windows\System32\drivers\etc\hosts"}
Function dbpCmd {cd "$env:USERPROFILE\AppData\Roaming\Minecraft Bedrock\Users\Shared\games\com.mojang\development_behavior_packs" }
Function drpCmd {cd "$env:USERPROFILE\AppData\Roaming\Minecraft Bedrock\Users\Shared\games\com.mojang\development_resource_packs" }
Function repoCmd {cd "$env:USERPROFILE\Documents\Repositories" }

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
Set-Alias -Name hosts -Value HostsCmd
Set-Alias -Name repo -Value repoCmd

Set-Alias originaldbp dbp
Remove-Item Alias:dbp -Force
Set-Alias -Name dbp -Value dbpCmd
Set-Alias -Name drp -Value drpCmd
Set-Alias -Name resource -Value resourceCmd
Set-Alias -Name behavior -Value behaviorCmd

Set-Alias -Name yz -Value y
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

Function pascal {
	param($file)
	$base = [System.IO.Path]::GetFileNameWithoutExtension($file)
	$tempPath = $env:TEMP

	Get-ChildItem "$tempPath\$base" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
	fpc -Mtp -FE"$env:TEMP" -FU"$env:TEMP" -Fo"$env:TEMP" $file | Out-Null
	if ($LASTEXITCODE -ne 0) {
		Write-Host "Compilation Failed."
		return
	}

	& "$env:TEMP\$base.exe"
}

function viCursor {
	if ($args[0] -eq 'Command') {
		Write-Host -NoNewLine "`e[2 q"
	} else {
		Write-Host -NoNewLine "`e[6 q"
	}
}


