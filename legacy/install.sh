#!/bin/bash

# EFFECTS:  Sets up standard vim, not neovim.
# TODO, set this up

source "`dirname $0`/global_constants.sh"

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
elif [ -h ~/.vimrc ]; then
    rm ~/.vimrc
fi

# Create symlink to this .vimrc
ln -s "$DIR/.vimrc" ~/.vimrc
