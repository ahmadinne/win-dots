# Path list
$glwmDirs = "$env:USERPROFILE\.config\glazewm"
$glwmPath = "$glwmDirs\config.yaml"

# Create Dir for path
if (!(Test-Path $glwmDirs)) { mkdir $glwmDirs }

# Set path to env. variable
[System.Environment]::SetEnvironmentVariable("GLAZEWM_CONFIG_PATH", $glwmPath, "Machine")

# Apply to current active session
$env:GLAZEWM_CONFIG_PATH = [System.Environment]::GetEnvironmentVariable("GLAZEWM_CONFIG_PATH", "Machine")

# psst.. you know, i just find out there's easier command for things above:
# but it only apply to User's env var
# setx GLAZEWM_CONFIG_PATH "$env:USERPROFILE\.config\config.yaml"
