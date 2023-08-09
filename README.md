Yilin Yang's Personal `.vimrc`
================================================================================
A repository containing my [(neo)](https://neovim.io/)vim configuration,
as well as the shell scripts that I use to install it onto new machines.

General Recommendations
--------------------------------------------------------------------------------
Some general vim settings (not plugins) that I find incredibly useful and am
likely to recommend to others.

### Silencing Swapback File Warnings - `settings.vimrc`
This makes it easier to simultaneously edit or view the same text file from
separate vim instances (e.g. if you use tmux, multiple terminal windows, etc.),
and makes it easier to reload vim session files even when old swapback files
still exist in the same directory.

### Reload Buffers When Files Change Outside of Vim - `bufferevents.vimrc`
gVim does this automatically, but vim instances that run in a terminal generally
don't. This makes it substantially easier to edit the same file from several
vim instances.
