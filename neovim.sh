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
pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim

# Symlink nvim's config folders to my ordinary vim config
mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.local/share/nvim/site
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

FTPLUGIN_FOLDER=~/.local/share/nvim/site/ftplugin
if [ -e $FTPLUGIN_FOLDER ]; then
    mv $FTPLUGIN_FOLDER $FTPLUGIN_FOLDER.bak
elif [ -h $FTPLUGIN_FOLDER ]; then
    rm $FTPLUGIN_FOLDER
fi
ln -s ~/.vim/ftplugin ~/.config/nvim/site
