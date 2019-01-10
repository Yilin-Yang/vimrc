#!/bin/bash

# EFFECTS:  Builds cquery from source and installs it.
# REQUIRES: CMake installation.

source "`dirname $0`/global_constants.sh"

cd /tmp
git clone --recursive https://github.com/cquery-project/cquery.git
cd cquery
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$HOME/.local/stow/cquery" -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
cmake --build .
cmake --build . --target install
