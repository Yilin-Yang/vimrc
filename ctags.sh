#!/bin/bash

# EFFECTS:  Install universal-ctags.

source "`dirname $0`/global_constants.sh"

cd /tmp
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install
