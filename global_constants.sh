#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
YILINYGIT="https://yiliny@bitbucket.org/yiliny"
INSTALLCMD="sudo apt-get install -y"
PIPINSTALL="pip3 install --user --upgrade"
YARNINSTALL="yarn global add"

# Start from Home Folder
cd ~/

# trap CTRL-C, have it terminate everything
trap "echo 'Terminated script.' && exit 0" SIGINT
