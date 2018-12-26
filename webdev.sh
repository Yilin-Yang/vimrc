#!/bin/bash

# EFFECTS:  - Locally installs HTML, CSS language servers.

source "`dirname $0`/global_constants.sh"

mkdir -p "$HOME/js"
cd "$HOME/js"

# TODO: use my cloned repos, or open a pull request?

git clone --recursive https://github.com/vscode-langservers/vscode-html-languageserver-bin
cd vscode-html-languageserver-bin
npm install
npm run build

cd "$HOME/js"

git clone --recursive https://github.com/vscode-langservers/vscode-css-languageserver-bin
cd vscode-css-languageserver-bin
npm install
npm run build
