#!/bin/bash

# EFFECTS:  Sets up (neo)vim, just the way I like it.

source "`dirname $0`/global_constants.sh"

$DIR/vim-plug.sh        # install vim-plug
$DIR/external_tools.sh  # install some dependencies
$DIR/neovim.sh          # install neovim

# Do some weird stuff to get Python working with lldb
#   From: https://github.com/dbgx/lldb.nvim/issues/6#issuecomment-127192347
$DIR/fix-lldb.sh

# Delete backup vimrc if you need to
if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi

# Create symlink to this .vimrc
ln -s "$DIR/.vimrc" ~/.vimrc

# Run PluginInstall
nvim -c 'PlugInstall' -c `qa!`
