#!/bin/bash
#!/bin/bash

source "`dirname $0`/global_constants.sh"

mkdir -p ~/.config
ln -s ~/vimrc ~/.config/nvim

if [ -d "~/.vim" ]; then
  mv ~/.vim ~/.vim.bak
fi
# We want ~/.vim to "be" our ~/vimrc repo.
ln -s ~/.config/nvim ~/.vim

# Can't use init.vim alongside init.lua because neovim will complain
ln -s ~/.config/nvim/vimrc ~/.vimrc
