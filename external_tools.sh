#!/bin/bash

# EFFECTS:  Installs programs that my vim configuration uses while I'm coding.

source "`dirname $0`/global_constants.sh"

# Install vim-plug
$DIR/vim-plug.sh

# Install recent clang version for LSP support
$DIR/llvm.sh

# Install palantir's Python language server
pip install --user python-language-server

# Install Kuniwak/vint
pip  install vim-vint
pip3 install vim-vint

# Install lldb for integrated debugger support
$INSTALLCMD lldb

# Install yamllint
#   Should work automatically with syntastic and neomake
$INSTALLCMD yamllint

# Install shellcheck, for bash script linting
$INSTALLCMD shellcheck

# Install cppcheck, for clang checking
$INSTALLCMD cppcheck

# Install ctags
$INSTALLCMD exuberant-ctags

# Install vimtex dependencies
$INSTALLCMD latexmk
