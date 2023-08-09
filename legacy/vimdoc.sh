#!/bin/bash

# EFFECTS:  Installs vimdoc.

source "`dirname $0`/global_constants.sh"

mkdir -p ~/temp
cd ~/temp
rm -rf vimdoc

git clone https://github.com/google/vimdoc
cd vimdoc
python3 setup.py config
python3 setup.py build
sudo python3 setup.py install
