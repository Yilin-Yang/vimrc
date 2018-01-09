#!/bin/bash

# EFFECTS:  Create a system-wide cquery configuration for
#           LanguageClient-neovim.
# REQUIRES: neovim is already installed.

NVIM_SETTINGS_DIR=~/.config/nvim
SETTINGS_FILE=$NVIM_SETTINGS_DIR/settings.json

if [ ! -f $SETTINGS_FILE ]; then
    touch $SETTINGS_FILE
fi

# Ideally, cquery should already be installed. Try to find the clang version it uses.
CQUERY_PREFIX_DIR="~/.local/stow/cquery"
CLANG_DIR="`ls $CQUERY_PREFIX_DIR/lib`"
if [ $CLANG_DIR ]; then
    RESOURCE_DIR="$CQUERY_PREFIX_DIR/lib/$CLANG_DIR"
else
    RESOURCE_DIR="$CQUERY_PREFIX_DIR/lib/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04"
fi

cat << EOF >> $SETTINGS_FILE
{
    "initializationOptions": {
        "cacheDirectory": "/tmp/cquery"
        "resourceDirectory": $RESOURCE_DIR
    }
}
EOF
