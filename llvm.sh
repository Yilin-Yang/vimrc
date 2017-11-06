#!/bin/bash

## Install llvm 5.0 with clang-tools-extra, for Language Server Protocol support
### Modify URL as needed.
CLANG_NAME=clang+llvm-5.0.0-linux-x86_64-ubuntu16.04
CLANG_ARCHIVE=$CLANG_NAME.tar.xz
wget https://releases.llvm.org/5.0.0/$CLANG_ARCHIVE
tar -xvf $CLANG_ARCHIVE
sudo cp -Rv $CLANG_NAME/* /usr/local
