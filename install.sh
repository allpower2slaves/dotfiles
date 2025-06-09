#!/bin/sh
# i didnt test it on anything posix. it should work with gnu coreutils

ln -isvn $(realpath ./mpv) ~/.config/mpv
ln -isvn $(realpath ./nvim) ~/.config/nvim
ln -isvn $(realpath ./fish) ~/.config/fish
ln -isvn $(realpath ./ghostty) ~/.config/ghostty

test ! -e ~/.zshrc && ln -iv $(realpath ./zsh/zshrc) ~/.zshrc 2>/dev/null
