#!/bin/bash

# EFFECTS:  Install llvm 6.0 with clang-tools-extra, for Language Server
#           Protocol support.

source "`dirname $0`/global_constants.sh"

$INSTALLCMD clang-tools-6.0 \
            clang-6.0
