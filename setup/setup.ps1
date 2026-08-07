# Setup!

#### Set the execution policy!
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#### Add PATH for some programs.
# Enable long-path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

#### Programs installation
./install-package.ps1
./install-github.ps1
./autostart/glazewm.ps1

# Path list
$filePath = "C:\Program Files\Git\usr\bin\file.exe"

# Create Dir for path
if (!(Test-Path $glwmDirs)) { mkdir $glwmDirs }

# Set path to env. variable
[System.Environment]::SetEnvironmentVariable("YAZI_FILE_ONE", $filePath, "Machine")

# Apply to current active session
$env:YAZI_FILE_ONE = [System.Environment]::GetEnvironmentVariable("YAZI_FILE_ONE", "Machine")

# psst.. you know, i just find out there's easier command for things above:
# but it only apply to User's env var
# setx YAZI_FILE_ONE "C:\Program Files\Git\usr\bin\file.exe"

## Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
