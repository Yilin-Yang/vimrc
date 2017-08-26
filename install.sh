#!/bin/bash

INSTALLCMD="sudo apt-get install -y"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
$INSTALLCMD neovim

## Enable python support in nvim
sudo apt install python3-pip
pip2 install --upgrade neovim
pip3 install --upgrade neovim

## Install libclang for deoplete-clang support
$INSTALLCMD clang

# Install yamllint
#	Should work automatically with syntastic and neomake
$INSTALLCMD yamllint

# Install ctags
$INSTALLCMD exuberant-ctags


# Delete backup vimrc if you need to
mv ~/.vimrc ~/.vimrc.bak

# Create symlink to this .vimrc
ln -s $DIR/.vimrc ~/.vimrc

mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
