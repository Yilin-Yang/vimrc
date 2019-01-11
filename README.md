Yilin Yang's Personal `.vimrc`
================================================================================
A public repository containing my [(neo)](https://neovim.io/)vim configuration,
as well as the shell scripts that I use to install it onto new machines.

I'm not necessarily providing this so that people can just use it "as-is", since
doing that would deprive them of the joy of getting their vim install to
work exactly how *they* like it. (It would also just make their config harder to
debug, since they wouldn't be familiar with where everything is.) It's meant
mostly as a reference, in case I'm helping a classmate configure vim and need
something to point at as I explain something.

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

An (Incomplete) List of (Hyperlinks to) Plugins That I Use
--------------------------------------------------------------------------------
For convenience's sake. (Not guaranteed to be current or comprehensive; see
`init.vimrc` for all plugins I'm currently using.)

* [BufExplorer](https://github.com/jlanzarotta/bufexplorer)
* [ReplaceWithRegister](https://github.com/vim-scripts/ReplaceWithRegister)
* [Tagbar](https://github.com/majutsushi/tagbar	)
* [UltiSnips](https://github.com/SirVer/ultisnips)
* [coc.nvim](https://github.com/neoclide/coc.nvim)
* [diffconflicts](https://github.com/whiteinge/diffconflicts)
* [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)
* [fuzzyfind-vim](https://github.com/junegunn/fzf.vim)
* [fuzzyfind](https://github.com/junegunn/fzf)
* [gv.vim](https://github.com/junegunn/gv.vim)
* [lldb](https://github.com/dbgx/lldb.nvim)
* [localvimrc](https://github.com/embear/vim-localvimrc)
* [neomake](https://github.com/neomake/neomake)
* [quick-scope](https://github.com/unblevable/quick-scope)
* [tabular](https://github.com/godlygeek/tabular)
* [traces.vim](https://github.com/markonm/traces.vim)
* [typescript-vim](https://github.com/leafgarland/typescript-vim)
* [vader.vim](https://github.com/junegunn/vader.vim)
* [vim-abolish](https://github.com/tpope/vim-abolish)
* [vim-airline](https://github.com/vim-airline/vim-airline)
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vim-easy-align](https://github.com/junegunn/vim-easy-align)
* [vim-easymotion](https://github.com/easymotion/vim-easymotion)
* [vim-easytags](https://github.com/xolox/vim-easytags)
* [vim-eunuch](https://github.com/tpope/vim-eunuch)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)
* [vim-lexical](https://github.com/reedes/vim-lexical)
* [vim-mundo](https://github.com/simnalamburt/vim-mundo)
* [vim-obsession](https://github.com/tpope/vim-obsession)
* [vim-peekaboo](https://github.com/junegunn/vim-peekaboo)
* [vim-pencil](https://github.com/reedes/vim-pencil)
* [vim-repeat](https://github.com/tpope/vim-repeat)
* [vim-rsi](https://github.com/tpope/vim-rsi)
* [vim-signature](https://github.com/kshenoy/vim-signature)
* [vim-signify](https://github.com/mhinz/vim-signify)
* [vim-snippets](https://github.com/honza/vim-snippets)
* [vim-surround](https://github.com/tpope/vim-surround)
* [vim-textobj-sentence](https://github.com/reedes/vim-textobj-sentence)
* [vim-textobj-user](https://github.com/kana/vim-textobj-user)
* [vim-tmux-focus-events](https://github.com/tmux-plugins/vim-tmux-focus-events)
* [vim-unimpaired](https://github.com/tpope/vim-unimpaired)
* [vim-vebugger](https://github.com/idanarye/vim-vebugger)
* [vim-wordy](https://github.com/reedes/vim-wordy)
* [vimtex](https://github.com/lervag/vimtex)
* [vimwiki](https://github.com/vimwiki/vimwiki)
* [winresizer](https://github.com/simeji/winresizer)

Plugins That I Wrote
--------------------------------------------------------------------------------
`>:D`

* [vim-markbar](https://github.com/Yilin-Yang/vim-markbar)
* dapper.nvim

Other Editing Tools
--------------------------------------------------------------------------------
Some additional tools that aren't packaged as vim plugins.

### Language Servers
The Language Server Protocol provides editor-agnostic IDE-like tools for
programming, such as semantic autocompletion, identifier renaming, and
asynchronous syntax-checking. Use with a language client, such as
LanguageClient-neovim.

* [clangd](https://clang.llvm.org/extra/clangd.html)
* [cquery](https://github.com/cquery-project/cquery)
* [python-language-server](https://github.com/palantir/python-language-server)

### Linters
Linters check for common coding mistakes, syntax errors, and antipatterns. Use
from the shell, or with a linting plugin such as Neomake or ALE.

* [vim-vint](https://github.com/Kuniwak/vint)
* [yamllint](https://github.com/adrienverge/yamllint)
