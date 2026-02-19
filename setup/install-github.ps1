#!\usr\bin\env powershell

if (Get-Command dan) {
	echo "Dan already installed."
} else {
	git clone https://github.com/ahmadinne/dan "$env:USERPROFILE/Documents/dan"
	. $env:USERPROFILE/Documents/dan/install.ps1
}

if (Get-Command bunnyfetch) {
	echo "Bunnyfetch already installed." 
} else {
	git clone https://github.com/ahmadinne/bunnyfetch "$env:USERPROFILE/Documents/bunnyfetch"
	. $env:USERPROFILE/Documents/bunnyfetch/install.ps1
}

# Autotiler
$auto = "$env:USERPROFILE\Documents\autotiler"
if (!(Test-Path $auto)) { 
	New-Item -ItemType Directory -Path "$auto" -Force

	Invoke-WebRequest `
		-Uri "https://github.com/orbi-tal/glaze-autotiler/releases/download/v1.0.3/glaze-autotiler.exe" `
		-Outfile "${auto}\glaze-autotiler.exe"
}
