# Setup!

#### Set the execution policy!
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#### Programs installation
./install-package.ps1
./install-github.ps1
./autostart/glazewm.ps1

#### Add PATH for some programs.
# Enable long-path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# Path list
$glwmDirs = "$env:USERPROFILE\.config\glazewm"
$glwmPath = "$glwmDirs\config.yaml"
$kmrbPath = "$env:USERPROFILE\.config\komorebi"
$filePath = "C:\Program Files\Git\usr\bin\file.exe"

# Create Dir for path
if (!(Test-Path $glwmDirs)) { mkdir $glwmDirs }
if (!(Test-Path $kmrbPath)) { mkdir $kmrbPath }

# Set to env. variable
[System.Environment]::SetEnvironmentVariable("GLAZEWM_CONFIG_PATH", $glwmPath, "Machine")
[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", $kmrbPath, "Machine")
[System.Environment]::SetEnvironmentVariable("YAZI_FILE_ONE", $filePath, "Machine")

# Apply to current active session
$env:GLAZEWM_CONFIG_PATH = [System.Environment]::GetEnvironmentVariable("GLAZEWM_CONFIG_PATH", "Machine")
$env:KOMOREBI_CONFIG_HOME = [System.Environment]::GetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "Machine")
$env:YAZI_FILE_ONE = [System.Environment]::GetEnvironmentVariable("YAZI_FILE_ONE", "Machine")

# psst.. you know, i just find out there's easier command for things above:
# setx GLAZEWM_CONFIG_PATH "C:\<PATH_TO_CONFIG>\config.yaml"
# setx YAZI_FILE_ONE "C:\Program Files\Git\usr\bin\file.exe"

## Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

dan 
