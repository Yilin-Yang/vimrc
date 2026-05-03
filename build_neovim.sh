#!/bin/bash

source "`dirname $0`/global_constants.sh"

git clone https://github.com/neovim/neovim.git
cd ~/neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
