#!/usr/bin/env powershell

# --- Configurations ---
$taskname = "GlazeWM"
$taskpath = "${HOME}\scoop\apps\glazewm\current\cli\glazewm.exe"
$taskdesc = "Autorun programs at start"
$taskfold = "\Autostart"

# --- Components ---
$action = New-ScheduledTaskAction -Execute $taskpath
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet `
	-AllowStartIfOnBatteries:$true `
	-DontStopIfGoingOnBatteries:$true `
	-ExecutionTimeLimit ([TimeSpan]::Zero) `
	-StartWhenAvailable:$false `

# --- Ensure the folder exist ---
$service = New-Object -ComObject "Schedule.Service"
$service.Connect()
$rootFolder = $service.GetFolder("\")
try {
	$null = $rootFolder.GetFolder("Autostart")
} catch {
	$rootFolder.CreateFolder("Autostart") | Out-Null
}

# --- Remove old task if exist ---
try {
	$existing = Get-ScheduledTask -TaskName $taskname -ErrorAction Stop
	if ($existing) {
		Unregister-ScheduledTask -TaskName $taskname -Confirm:$false
		Write-Host "Old task '$taskname' removed."
	}
} catch {
	Write-Host "No existing task found, creating a new one..."
}

# --- Register Task ---
Register-ScheduledTask `
	-TaskName $taskname `
	-TaskPath $taskfold `
	-Action $action `
	-Trigger $trigger `
	-Principal $principal `
	-Settings $settings `
	-Description $taskdesc

if ($?) { Write-Host "Task '$taskname' successfully registered in folder '$taskfold'." }
