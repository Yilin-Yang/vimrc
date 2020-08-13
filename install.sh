#!/bin/bash

# EFFECTS:  Sets up (neo)vim, just the way I like it.

source "`dirname $0`/global_constants.sh"

"$DIR/vim-plug.sh"        # install vim-plug
"$DIR/external_tools.sh"  # install some dependencies
"$DIR/neovim.sh"          # install neovim

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
elif [ -h ~/.vimrc ]; then
    rm ~/.vimrc
fi

"$DIR/symlink.sh"

# Create symlink to this .vimrc
ln -s "$DIR/.vimrc" ~/.vimrc

# Run PluginInstall
nvim -c 'PlugInstall' -c 'qa!'
