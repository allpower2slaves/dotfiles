#!/bin/sh
# i didnt test it on anything posix. it should work with gnu coreutils

classic_dirs="mpv nvim fish ghostty wayland" # list of 
xdg_config="$HOME/.config" # because this thing will be ran on BSD and other unixes

# ~/.config/ creation
test -d $xdg_config || mkdir -p $xdg_config

# classic dir linking TODO: maybe fix filenames with space? (i mean i just copy configs lol)
printf "$classic_dirs\n" | tr ' ' '\n' | while read directory; do
	target="$xdg_config/$directory"
	printf "$target\n" #debug
	ln -svif $(realpath $directory) $target 
done

# zsh 
ln -svif $(realpath ./zsh/zshrc) $HOME/.zshrc

cp startwl ~/bin/startwl # TODO: if on linux, use `~/.local/bin`
