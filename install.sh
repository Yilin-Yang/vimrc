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
$INSTALLCMD python-pip
$INSTALLCMD python3-pip
pip2 install --upgrade neovim
pip3 install --upgrade neovim

## Install libclang for deoplete-clang support
$INSTALLCMD clang

## Install lldb for integrated debugger support
$INSTALLCMD lldb

# Install yamllint
#	Should work automatically with syntastic and neomake
$INSTALLCMD yamllint

# Install shellcheck, for bash script linting
$INSTALLCMD shellcheck

# Install cppcheck, for clang checking
$INSTALLCMD cppcheck;

# Install ctags
$INSTALLCMD exuberant-ctags

# Do some weird stuff to get Python working with lldb
#   From: https://github.com/dbgx/lldb.nvim/issues/6#issuecomment-127192347
./fix-lldb.sh

# Install vimtex dependencies
$INSTALLCMD latexmk

# Delete backup vimrc if you need to
mv ~/.vimrc ~/.vimrc.bak

# Create symlink to this .vimrc
ln -s "$DIR/.vimrc" ~/.vimrc

mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Run PluginInstall
nvim -c 'PluginInstall' -c `qa!`
