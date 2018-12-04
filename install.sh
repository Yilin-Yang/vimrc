#!/bin/bash

# EFFECTS:  Sets up (neo)vim, just the way I like it.

source "`dirname $0`/global_constants.sh"

"$DIR/vim-plug.sh"        # install vim-plug
"$DIR/external_tools.sh"  # install some dependencies
"$DIR/neovim.sh"          # install neovim

# Do some weird stuff to get Python working with lldb
#   From: https://github.com/dbgx/lldb.nvim/issues/6#issuecomment-127192347
"$DIR/fix-lldb.sh"

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
elif [ -h ~/.vimrc ]; then
    rm ~/.vmrc
fi
if [ -e ~/.vim/ftplugin ]; then
    mv ~/.vim/ftplugin ~/.vim/ftplugin.bak
elif [ -h ~/.vim/ftplugin ]; then
    rm ~/.vim/ftplugin
fi

# Create symlink to this .vimrc, ftplugin
ln -s "$DIR/.vimrc" ~/.vimrc
ln -s "$DIR/ftplugin" ~/.vim/

# Run PluginInstall
nvim -c 'PlugInstall' -c 'qa!'
