#! /C:/Users/ahmadinne/scoop/apps/git/current/bin/bash

# Configuration's
eval "$(starship init bash)"

# Environments
EDITOR="nvim"
HOME="C:/Users/ahmadinne"

# Aliases
alias less='moor'
alias ls='eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions -a'
alias cat='bat'
alias vi=$EDITOR
alias vim=$EDITOR
alias neovim=$EDITOR
alias init.lua="$EDITOR $HOME/Appdata/Local/nvim/init.lua"
alias alacritty.toml="$EDITOR $HOME/Appdata/Roaming/alacritty/alacritty.toml"

# Functions
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
alias yazi=y

function pacman() {
	option=$1
	choice=$(echo "${@:2}")

	case $option in
		-h|--help) powershell -c scoop help ;;
		-Sy)	powershell -c scoop update ;;
		-Syu)	powershell -c scoop update * ;;
		-S)		powershell -c scoop install $choice ;;
		-R)		powershell -c scoop uninstall $choice ;;
		-Ss)	powershell -c scoop search $choice ;;
		-Su)	powershell -c scoop update $choice ;;
	esac
}
