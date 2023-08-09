#!/bin/bash

# EFFECTS:  Symlinks the default neovim spellfile to the spellfile in this
#           repository.

source "`dirname $0`/global_constants.sh"

NVIM_SPELLFILE_DIR=~/.local/share/nvim/site/spell
NVIM_SPELLFILE_DEST=$NVIM_SPELLFILE_DIR/en.utf-8.add

mkdir -p $NVIM_SPELLFILE_DIR

[ -f $NVIM_SPELLFILE_DEST ] && mv $NVIM_SPELLFILE_DEST $NVIM_SPELLFILE_DEST.bak

ln -s $DIR/spellfile/en.utf-8.add $NVIM_SPELLFILE_DEST
