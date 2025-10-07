foreach ($pkg in Get-Content packages.txt) {
    $path = "$HOME\scoop\apps\$pkg"
    if (Test-Path $path) {
        Write-Output "$pkg already installed"
    }
	else {
		scoop install $pkg
	}
}
