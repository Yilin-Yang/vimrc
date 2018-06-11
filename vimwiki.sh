#!/bin/bash

# REQUIRES: The addition of `g:tagbar_type_vimwiki` to the vimrc, as specified
#           in `vwtags.py` itself.
# EFFECTS:  Enables "Table of Contents" for vimwiki files in tagbar.

source "`dirname $0`/global_constants.sh"

curl -fLo $DIR/misc/vwtags.py --create-dirs \
    https://raw.githubusercontent.com/vimwiki/utils/master/vwtags.py
chmod +x $DIR/misc/vwtags.py
