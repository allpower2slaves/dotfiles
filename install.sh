#!/bin/sh
# i didnt test it on anything posix. it should work with gnu coreutils

ln -isvn $(realpath ./mpv) ~/.config/mpv
ln -isvn $(realpath ./nvim) ~/.config/nvim
ln -isvn $(realpath ./fish) ~/.config/fish
ln -isvn $(realpath ./ghostty) ~/.config/ghostty

#test ! -e ~/.local/share/nvim/site/autoload/plug.vim  && command -v nvim >/dev/null && \
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#test "$XDG_CURRENT_DESKTOP" = "GNOME" && \
#	dconf load / < ./gnome-setup.dconf
