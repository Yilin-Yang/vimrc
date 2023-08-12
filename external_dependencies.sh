#!/bin/bash
#
source "$(dirname $0)/global_constants.sh"

# So that telescope.nvim will support livegrep: the ability to recursively
# ripgrep through every file in CWD on down.
$INSTALLCMD ripgrep

# So that nvim-dap-python will work correctly.
$PIPINSTALL debugpy
