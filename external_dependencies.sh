#!/bin/bash
#
source "$(dirname $0)/global_constants.sh"

printf "External dependencies that need manual installation are:\n"
printf "clang-tools-extra; stylua"
printf "\n"

# So that telescope.nvim will support livegrep: the ability to recursively
# ripgrep through every file in CWD on down.
$INSTALLCMD ripgrep

# So that nvim-dap-python will work correctly.
$PIPINSTALL debugpy

# Python linters
$PIPINSTALL pylint pydocstyle pycodestyle
