#!/bin/bash
if [ `dirname $0` == '.' ]; then
	echo "Don't run from this directory (doesn't work and Yilin is lazy!)"
	echo "Clone vimrc into a folder in your home folder, then run from your home folder!"
	exit
fi

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# Install yamllint
#	Should work automatically with syntastic and neomake
sudo apt install yamllint

# Delete backup vimrc if you need to
mv ~/.vimrc ~/.vimrc.bak

# Create symlink to this .vimrc
ln -s `dirname $0`/.vimrc ~/.vimrc

mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
