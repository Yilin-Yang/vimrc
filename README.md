Yilin Yang's Personal `.vimrc`
================================================================================
A repository containing my [(neo)](https://neovim.io/)vim configuration,
as well as the shell scripts that I use to install it onto new machines.

No longer public. It still works, but I'm a bit embarrassed at how bloated it
is.

If you want to get a sense of how this repo is structured, start by looking at
`.vimrc`.

General Recommendations
--------------------------------------------------------------------------------
Some general vim settings (not plugins) that I find incredibly useful and am
likely to recommend to others.

### Silencing Swapback File Warnings - `settings.vimrc`
This makes it easier to simultaneously edit or view the same text file from
separate vim instances (e.g. if you use tmux, multiple terminal windows, etc.),
and makes it easier to reload vim session files even when old swapback files
still exist in the same directory. That last feature also makes [tmux-resurrect's](https://github.com/tmux-plugins/tmux-resurrect)
vim [session restoration](https://github.com/tmux-plugins/tmux-resurrect/blob/master/docs/restoring_vim_and_neovim_sessions.md)
work properly, which is a nice bonus.

### Reload Buffers When Files Change Outside of Vim - `bufferevents.vimrc`
gVim does this automatically, but vim instances that run in a terminal generally
don't. This makes it substantially easier to edit the same file from several
vim instances.
