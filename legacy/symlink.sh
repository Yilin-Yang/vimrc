#!/bin/bash

# EFFECTS:  Creates symlinks to this repo's vim runtime directories.

source "`dirname $0`/global_constants.sh"

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
    autoload
    bundle
    colors
    ftdetect
    ftplugin
    indent
    lua
    undo
"
removeOrBackupDir "$HOME/.vim" "$DIR" "$FOLDERS"
