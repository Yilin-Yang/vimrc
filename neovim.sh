#!/bin/bash

source "`dirname $0`/global_constants.sh"

$INSTALLCMD neovim

# Symlink nvim and vim's user-accessible config folders to the top-level of
# this repo
mkdir -p ~/.config
mkdir -p ~/.vim
ln -s ~/vimrc ~/.config/nvim
ln -s ~/.config/nvim ~/.vim

# Can't use init.vim alongside init.lua because neovim will complain
ln -s ~/.vimrc ~/.config/nvim/vimrc
