#!/usr/bin/env powershell

# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Add some scoop buckets
scoop bucket add extras
scoop bucket add nerd-fonts
