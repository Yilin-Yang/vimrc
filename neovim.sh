#!/bin/bash

# EFFECTS:  Installs neovim and its extras.

source "`dirname $0`/global_constants.sh"

# Set up nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
$INSTALLCMD neovim

# Enable python remote plugin support in nvim
$INSTALLCMD python-pip
$INSTALLCMD python3-pip
pip2 install --upgrade neovim
pip3 install --upgrade neovim

# Symlink nvim's config folders to my ordinary vim config
mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
