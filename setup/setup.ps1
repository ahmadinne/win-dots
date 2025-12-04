# Setup!

# Enable long-path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# Set config path for komorebi
$path = "$env:USERPROFILE\.config\komorebi"

if (!(Test-Path $path)) {
    mkdir $path
}

[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", $path, "Machine")
$env:KOMOREBI_CONFIG_HOME = [System.Environment]::GetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "Machine")
