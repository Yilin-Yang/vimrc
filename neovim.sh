#!/bin/bash

set -Eeuo pipefail
set -x

source "`dirname $0`/global_constants.sh"

$INSTALLCMD neovim

# Symlink nvim and vim's user-accessible config folders to the top-level of
# this repo
mkdir -p ~/.config
ln -s ~/vimrc ~/.config/nvim

if [ -d "~/.vim" ]; then
  mv ~/.vim ~/.vim.bak
fi
# We want ~/.vim to "be" our ~/vimrc repo.
ln -s ~/.config/nvim ~/.vim

# Can't use init.vim alongside init.lua because neovim will complain
ln -s ~/.config/nvim/vimrc ~/.vimrc

"$DIR/external_dependencies.sh"
