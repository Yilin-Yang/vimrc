#!/bin/bash

# EFFECTS:  Sets up (neo)vim, just the way I like it.

source "`dirname $0`/global_constants.sh"

"$DIR/vim-plug.sh"        # install vim-plug
"$DIR/external_tools.sh"  # install some dependencies
"$DIR/neovim.sh"          # install neovim
"$DIR/coc.sh"             # install CoC

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
elif [ -h ~/.vimrc ]; then
    rm ~/.vimrc
fi

# EFFECTS:  Removes symlinks if present; moves existing folders to a folder
#           with the same name, but with the suffix `.bak`.
# PARAM:    $1  (string)    Directory to examine; "destination folder."
# PARAM:    $2  (string)    "Source folder;" symlinks point to folders here.
# PARAM:    $3  (string)    Whitespace-separated list of folders to check.
function removeOrBackupDir() {
    DEST=$1
    SOURCE=$2
    FOLDERS=$3

    for FOLDER in $FOLDERS; do
        FOLDER_PATH="$DEST/$FOLDER"
        if [ -h "$FOLDER_PATH" ]; then
            rm "$FOLDER_PATH"
        elif [ -d "$FOLDER_PATH" ]; then
            mv "$FOLDER_PATH" "$FOLDER_PATH.bak"
        fi
        ln -s "$SOURCE/$FOLDER" "$FOLDER_PATH"
    done
}

FOLDERS="
    after
    ftplugin
    ftdetect
    indent
"
removeOrBackupDir "$HOME/.vim" "$DIR" "$FOLDERS"

# Create symlink to this .vimrc
ln -s "$DIR/.vimrc" ~/.vimrc

# Run PluginInstall
nvim -c 'PlugInstall' -c 'qa!'

# Run CocInstall
nvim -c 'call InstallCoCExtensions()' -c 'qa!'
