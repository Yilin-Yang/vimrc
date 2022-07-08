#!/bin/bash

# EFFECTS:  Installs extras related to neovim.
# NOTES:    It is assumed that the user is building and installing
#           neovim locally.

source "`dirname $0`/global_constants.sh"

$INSTALLCMD neovim

# Enable python remote plugin support in nvim
$INSTALLCMD python3-pip
$INSTALLCMD python3-dev
pip3 install --user --upgrade pynvim

# Symlink nvim's config folders to my ordinary vim config
mkdir -p ~/.config
mkdir -p ~/.vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
