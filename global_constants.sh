#!/bin/bash

set -Eeuo pipefail
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALLCMD="sudo apt-get install -y --fix-missing"
YARNINSTALL="yarn global add"

# Start from Home Folder
cd ~/

# trap CTRL-C, have it terminate everything
trap "echo 'Terminated script.' && exit 0" SIGINT
