Yilin Yang's Personal `init.lua`
================================================================================
A repository containing my [(neo)](https://neovim.io/)vim configuration,
as well as the shell scripts that I use to install it onto new machines.

This repo used to be pretty bloated: It was written entirely in vimscript while
I was a college underclassman trying too hard to impress his peers, back when
asynchronous linters like ALE and Neomake were dominant and before plugin
developers were exploring Language Server Protocol integration.

It worked well at the time. It was much better than editing in Gedit, as some
of my classmates did. With ALE and coc.nvim, I was able to use my neovim config
at successful internships.

But there came a point where the best new plugins all seemed to be written in
lua. I'd structured the repo to try to be mostly backwards compatible with vim,
down to using vim-focused package managers like vim-plug instead of packer.nvim
or lazy.nvim. That was fine when most plugins were built foremost for vim
compatibility, but not when they targeted neovim *only.*

I've rebuilt my config around [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim),
largely because of how its LSP, completion engine, and telescope configurations
worked out-of-the-box. Basic configuration options like keybinds still go into
`./vimrc`, which is sourced from my `init.lua`.
