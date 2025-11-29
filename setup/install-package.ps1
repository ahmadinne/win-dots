foreach ($pkg in Get-Content packages.txt) {
    if (Winget list $pkg | sls $pkg) {
        Write-Output "$pkg already installed"
    }
	else {
		scoop install $pkg
	}
}
