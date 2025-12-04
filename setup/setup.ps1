# Setup!

$path = "$env:USERPROFILE\.config\komorebi"

if (!(Test-Path $path)) {
    mkdir $path
}

[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", $path, "Machine")
$env:KOMOREBI_CONFIG_HOME = [System.Environment]::GetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "Machine")
