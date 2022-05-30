#!/bin/bash

# EFFECTS:  Installs programs that my vim configuration uses while I'm coding.

source "$(dirname $0)/global_constants.sh"

# Install python3-venv, dependency for coq_nvim
$INSTALLCMD python3-venv

# Install mypy, for static type checking
$PIPINSTALL mypy

# Install Python LSP
$PIPINSTALL python-lsp-server

# Install lua-lsp (https://github.com/Alloyed/lua-lsp)
# note: $HOME/.luarocks/bin must be in $PATH
$INSTALLCMD luarocks lua5.1
luarocks --local install --server=http://luarocks.org/dev lua-lsp
luarocks --local install luacheck

# Install Kuniwak/vint
pip  install --user --upgrade vim-vint
pip3 install --user --upgrade vim-vint

# Install yamllint
#   Should work automatically with syntastic and neomake
$INSTALLCMD yamllint

# Install shellcheck, for bash script linting
$INSTALLCMD shellcheck

# Install cppcheck, for clang checking
$INSTALLCMD cppcheck

# Install vimtex dependencies
$INSTALLCMD latexmk

# Install plantuml dependencies
$INSTALLCMD graphviz

# Install vim-language-server
$YARNINSTALL vim-language-server

$YARNINSTALL bash-language-server

# html, css, json, eslint
$YARNINSTALL vscode-langservers-extracted

# Install lemminx language server for XML
"$DIR/xml.sh"
