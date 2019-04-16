#!/bin/bash

# EFFECTS:  Installs programs that my vim configuration uses while I'm coding.

source "`dirname $0`/global_constants.sh"

# Install vim-plug
"$DIR/vim-plug.sh"

# Install recent clang version for LSP support
"$DIR/llvm.sh"

# Install palantir's Python language server
pip install  --user --upgrade python-language-server

# Install lua-lsp (https://github.com/Alloyed/lua-lsp)
# note: $HOME/.luarocks/bin must be in $PATH
$INSTALLCMD luarocks
luarocks --local install --server=http://luarocks.org/dev lua-lsp
luarocks --local install luacheck

# Install Kuniwak/vint
pip  install --user --upgrade vim-vint
pip3 install --user --upgrade vim-vint

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
"$DIR/ctags.sh"

# Install vimtex dependencies
$INSTALLCMD latexmk
