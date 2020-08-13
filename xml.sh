#!/bin/bash

# Install the eclipse/lemminx XML language server.

source "$(dirname $0)/global_constants.sh"

sudo apt install -y maven

cd temp || exit 1
git clone https://github.com/eclipse/lemminx.git || exit 1
cd lemminx || exit 1
mvn clean verify \
  && cp org.eclipse.lemminx/target/org.eclipse.lemminx-uber.jar "$DIR"
