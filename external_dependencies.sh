#!/bin/bash

source "$(dirname $0)/global_constants.sh"

$INSTALLCMD python3 python3-pip
$INSTALLCMD python3-pynvim

# Python language server
$INSTALLCMD python3-pylsp

# So that telescope.nvim will support livegrep: the ability to recursively
# ripgrep through every file in CWD on down.
$INSTALLCMD ripgrep

# So that nvim-dap-python will work correctly.
$INSTALLCMD python3-debugpy

# Python linters
$INSTALLCMD pylint pydocstyle pycodestyle

# SQL linter
$INSTALLCMD sqlfluff
