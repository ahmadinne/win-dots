#!/usr/bin/env powershell

function install {
	foreach ($pkg in ($choice -split " ")) {
		scoop install $pkg
	}
}

function uninstall {
	foreach ($pkg in ($choice -split " ")) {
		scoop uninstall $pkg
	}
}

function update {
	foreach ($pkg in ($choice -split " ")) {
		scoop update $pkg
	}
}

function updateall {
	foreach ($pkg in ($choice -split " ")) {
		scoop update *
	}
}

function search {
	foreach ($pkg in ($choice -split " ")) {
		scoop search $pkg
	}
}

function pacman {
	# Variables
	$option = $args[0]
	if ($args.Length -gt 1) {
		$choice = $args[1..($args.Length - 1)] -join " " 
	} else { $choice = "" }
	# case in
	switch ($option) {
		"-S" { install }
		"-Sy" { update }
		"-Syu" { updateall }
		"-R" { uninstall }
		"-Q" { scoop list }
		"-Ss" { search }
		Default { help }
	}
}
