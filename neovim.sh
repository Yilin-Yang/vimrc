#!/bin/bash

source "`dirname $0`/global_constants.sh"

$INSTALLCMD neovim

# Symlink nvim's config folders to my ordinary vim config
mkdir -p ~/.config
mkdir -p ~/.vim
ln -s ~/vimrc ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
ln -s ~/.vimrc ~/.config/nvim/vimrc
