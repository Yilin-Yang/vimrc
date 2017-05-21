#!/bin/bash

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# Delete backup vimrc if you need to
mv ~/.vimrc ~/.vimrc.bak

# Create symlink to this .vimrc
ln -s `dirname $0` ~/.vimrc

mkdir ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
