#!/bin/bash

# EFFECTS:  Installs a JavaScript/TypeScript language server.
# REQUIRES: - neovim is already installed.
#           - Recent version of Node.js is installed.

source "`dirname $0`/global_constants.sh"

# in home folder
mkdir -p $HOME/js
cd js

git clone https://github.com/sourcegraph/javascript-typescript-langserver.git
cd javascript-typescript-langserver

npm install
npm run build
