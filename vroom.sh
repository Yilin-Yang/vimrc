#!/bin/bash

# EFFECTS:  Installs vroom, Google's test framework for vim.
# REQUIRES: - Python3 installation.

source "`dirname $0`/global_constants.sh"

cd /tmp
git clone https://github.com/google/vroom.git
cd vroom
python3 setup.py build
sudo python3 setup.py install
