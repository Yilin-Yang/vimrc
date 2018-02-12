#!/bin/bash

# Taken from: https://stackoverflow.com/a/31005690
# Modified to use libLLVM-3.8 rather than 3.6, since these files are in 3.8
#   on my personal machine.

sudo apt-get install -y lldb

cd /usr/lib/llvm-3.8/lib/python2.7/site-packages/lldb
sudo rm _lldb.so
sudo ln -s ../../../liblldb.so.1 _lldb.so
sudo rm libLLVM-3.8.0.so.1
sudo ln -s ../../../libLLVM-3.8.0.so.1 libLLVM-3.8.0.so.1
sudo rm libLLVM-3.8.so.1
sudo ln -s ../../../libLLVM-3.8.0.so.1 libLLVM-3.8.so.1
export PYTHONPATH='/usr/lib/llvm-3.8/lib/python2.7/site-packages'
