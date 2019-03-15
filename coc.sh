#!/bin/bash

# EFFECTS:  Installs external dependencies needed by coc.nvim.

source "`dirname $0`/global_constants.sh"

# Install yarn, if not already installed
if [ ! "`which yarn`" ]; then
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
fi

# Install Watchman, to notify language servers of updates to watched source
# files, using the following link: https://medium.com/@vonchristian/how-to-setup-watchman-on-ubuntu-16-04-53196cc0227c
if [ ! "`which watchman`" ]; then
  cd /tmp
  git clone https://github.com/facebook/watchman.git
  cd watchman/
  VERSION='v4.9.0'
  echo "Checking out $VERSION, which might not be the newest stable release."
  git checkout "$VERSION"
  $INSTALLCMD autoconf automake build-essential python-dev
  ./autogen.sh
  ./configure
  make
  sudo make install

  watchman --version
  echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_queued_events && echo 999999 | sudo tee  -a /proc/sys/fs/inotify/max_user_instances && watchman shutdown-server
fi

# Symlink the coc-settings JSON file
ln -s "$DIR/coc-settings.json" ~/.vim
