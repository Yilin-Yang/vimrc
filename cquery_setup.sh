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
cat << EOF >> $SETTINGS_FILE
{
    "initializationOptions": {
        "cacheDirectory": "/tmp/cquery",
    }
}
EOF
