#!/bin/sh

xdg_config_dir="$HOME/.config" # because this thing will be ran on BSD and other unixes

# ~/.config/ creation
test -d "$xdg_config_dir" || mkdir -p "$xdg_config_dir"

# the symlink function
linkitem(){
	if [ -L "$2" ] || [ ! -e "$2" ]; then 
		rm -fv "$2"
		ln -fsv "$(realpath $1)" "$(realpath "$2")" # isnt the second realpath reduntant tho
	else
		printf "%s\n" ""$2" is a not a symbolic link, skipping..." 1>&2
	fi
}

# install stuff in ~/.config
printf "%s " "nvim mpv" | tr ' ' '\n' | while read __src; do
	linkitem "$__src" ""$xdg_config_dir"/"$__src""
done

# zsh, bash and nex/nvi
printf "%s " "zshrc zshenv bashrc nexrc zprofile" | tr ' ' '\n' | while read __src; do
	linkitem "$__src" ""$HOME"/".$__src""
done
