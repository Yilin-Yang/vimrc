#!/bin/bash

# EFFECTS:  Create a system-wide cquery configuration for
#           LanguageClient-neovim.
# REQUIRES: neovim is already installed.

NVIM_SETTINGS_DIR=~/.config/nvim
SETTINGS_FILE=$NVIM_SETTINGS_DIR/settings.json

if [ ! -f $SETTINGS_FILE ]; then
    touch $SETTINGS_FILE
fi

cat << EOF >> $SETTINGS_FILE
{
    "initializationOptions": {
        "cacheDirectory": "/tmp/cquery"
        "resourceDirectory": "~/.local/stow/cquery/lib/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04"
    }
}
EOF
