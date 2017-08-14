#!/bin/bash
if [ `dirname $0` == '.' ]; then
	echo "Don't run from this directory (doesn't work and Yilin is lazy!)"
	echo "Clone vimrc into a folder in your home folder, then run from your home folder!"
	exit
fi

INSTALLCMD="sudo apt-get install -y"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
$INSTALLCMD neovim

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
