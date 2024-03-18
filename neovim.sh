#!/bin/bash

source "`dirname $0`/global_constants.sh"

$INSTALLCMD neovim

# Symlink nvim and vim's user-accessible config folders to the top-level of
# this repo
"$DIR/symlink.sh"

# Install external dependencies
"$DIR/external_dependencies.sh"
