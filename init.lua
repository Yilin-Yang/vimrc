----------------------
-- TABLE OF CONTENTS --
-----------------------
-- CONFIG_FUGITIVE
-- CONFIG_RHUBARB
-- CONFIG_SURROUND
-- CONFIG_SLEUTH
-- CONFIG_EDITORCONFIG
-- CONFIG_RSI
-- CONFIG_WINRESIZER
-- CONFIG_EUNUCH
-- CONFIG_BUFEXPLORER
-- CONFIG_UNIMPAIRED
-- CONFIG_DIFFCONFLICTS
-- CONFIG_EASYMOTION
-- CONFIG_REPEAT
-- CONFIG_EASYALIGN
-- CONFIG_QUICKSCOPE
-- CONFIG_VADER
-- CONFIG_SIGNATURE
-- CONFIG_VIMWIKI
-- CONFIG_VIMTEX
-- CONFIG_JINJA
-- CONFIG_TODO
-- CONFIG_NERDTREE
-- CONFIG_TMUX
-- CONFIG_SYNCOPATE
-- CONFIG_LANGUAGE_SMARTS
-- CONFIG_NIO
-- CONFIG_DAP_UI
-- CONFIG_FORMATTER
-- CONFIG_LINTERS
-- CONFIG_WHICHKEY
-- CONFIG_GITSIGNS
-- CONFIG_COLORSCHEME
-- CONFIG_HIGHLIGHTWHITESPACE
-- CONFIG_LUALINE
-- CONFIG_MARKBAR
-- CONFIG_INDENTBLANKLINE
-- CONFIG_VISUALCOMMENT
-- CONFIG_REPLACEWITHREGISTER
-- CONFIG_LUASNIPS
-- CONFIG_TELESCOPE
-- CONFIG_LSPCONFIG
-- CONFIG_KEYMAPS
-- CONFIG_AUTOFORMAT
-- CONFIG_CMP
-- CONFIG_TREESITTER

local home = os.getenv('HOME')

-- Convenience function for pretty-printing lua tables
function PrintTable(tbl, indent)
  if not indent then
    indent = 0
  end
  for key, value in pairs(tbl) do
    local formatting = string.rep('  ', indent) .. key .. ': '
    if type(value) == 'table' then
      print(formatting)
      PrintTable(value, indent + 1)
    else
      print(formatting .. tostring(value))
    end
  end
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
--
--    lazy.nvim installs plugins to: ~/.local/share/nvim/lazy/
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- CONFIG_FUGITIVE
  -- Git related plugins
  'tpope/vim-fugitive',

  -- CONFIG_RHUBARB
  -- GitHub integration for vim-fugitive
  'tpope/vim-rhubarb',

  -- CONFIG_SURROUND
  -- Actions for working in and around braces.
  'tpope/vim-surround',

  -- CONFIG_SLEUTH
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- CONFIG_EDITORCONFIG
  -- Configure based on the local .editorconfig file
  'editorconfig/editorconfig-vim',

  -- CONFIG_RSI
  -- Readline-style bindings on the vim command line.
  'tpope/vim-rsi',

  -- CONFIG_WINRESIZER
  { -- Easier binds for resizing splits.
    'simeji/winresizer',
    config = function()
      vim.g.winresizer_keycode_finish = 100 -- finish by pressing 'd'
      vim.keymap.del('n', '<C-e>', { silent = true })
      vim.keymap.set('n', '<leader>wr', ':WinResizerStartResize<cr>', { desc = 'Start WinResizer' })
      vim.keymap.set('n', '<leader>wm', ':WinResizerStartMove<cr>', { desc = 'Start WinResizerMove' })
    end,
  },

  -- CONFIG_EUNUCH
  -- :Delete, :Move, :Rename, Mkdir...
  'tpope/vim-eunuch',

  -- CONFIG_BUFEXPLORER
  { -- Open another existing buffer in the current window.
    'jlanzarotta/bufexplorer',
    config = function()
      vim.g.bufExplorerFindActive = 0

      -- Clear default keymaps
      vim.keymap.del('n', '<leader>be')
      vim.keymap.del('n', '<leader>bt')
      vim.keymap.del('n', '<leader>bs')
      vim.keymap.del('n', '<leader>bv')

      vim.keymap.set('n', '<leader>bb', ':BufExplorer<cr>')
      -- <Leader>bb to open BufExplorer in the current window.
    end,
  },

  -- CONFIG_UNIMPAIRED
  -- ]q is cnext, [q is :cprevious, ]a is :next, [b is :bprevious...
  -- [<Space> (add line before current) and ]<Space> (add line after current)
  --
  -- PASTING                                         *unimpaired-pasting*
  --
  --   These are experimental:
  --
  -- >p    Paste after linewise, increasing indent.
  -- >P    Paste before linewise, increasing indent.
  -- <p    Paste after linewise, decreasing indent.
  -- <P    Paste before linewise, decreasing indent.
  -- =p    Paste after linewise, reindenting.
  -- =P    Paste before linewise, reindenting.
  --
  -- |]p|, |[p|, |[P|, and |]P| have also been remapped to force linewise pasting,
  -- while preserving their usual indent matching behavior.
  --
  -- *[op* *]op* *yop*
  -- A toggle has not been provided for 'paste' because the typical use case of
  -- wrapping of a solitary insertion is inefficient:  You toggle twice, but
  -- you only paste once (YOPO).  Instead, press [op, ]op, or yop to invoke |O|,
  -- |o|, or |0||C| with 'paste' already set.  Leaving insert mode sets 'nopaste'
  -- automatically.

  'tpope/vim-unimpaired',

  -- CONFIG_DIFFCONFLICTS
  { -- Easy, intuitive two-way git diffs!
    -- Note: DiffConflictsShowHistory, if we need the three-way diff.
    'whiteinge/diffconflicts',
  },

  -- CONFIG_EASYMOTION
  { -- Target and jump to a specific character,
    'easymotion/vim-easymotion',
    config = function()
      -- Double-tap localleader (backslash) to move to any word onscreen
      vim.keymap.set('n', '<localleader><localleader>', '<Plug>(easymotion-overwin-w)')
      vim.g.EasyMotion_smartcase = 1
    end,
  },

  -- Local .vimrc settings.
  -- 'embear/vim-localvimrc',

  -- CONFIG_REPEAT
  -- Repeat vim-surround commands using the period command.
  'tpope/vim-repeat',

  -- CONFIG_EASYALIGN
  -------------------------------------------------------------------------------
  -- Alignment:    after entering EasyAlign, use Enter to cycle through left,
  --               right, and center alignment options.
  -------------------------------------------------------------------------------
  --
  -------------------------------------------------------------------------------
  -- Examples:
  ----------------------+------------------------------------+--------------------
  -- With visual map     | Description                        | Equivalent command
  ----------------------+------------------------------------+--------------------
  -- <Enter>e<Space>    | Around 1st whitespaces             | :'<,'>EasyAlign\
  -- <Enter>e2<Space>   | Around 2nd whitespaces             | :'<,'>EasyAlign2\
  -- <Enter>e-<Space>   | Around the last whitespaces        | :'<,'>EasyAlign-\
  -- <Enter>e-2<Space>  | Around the 2nd to last whitespaces | :'<,'>EasyAlign-2\
  -- <Enter>e:          | Around 1st colon ( `key:  value` ) | :'<,'>EasyAlign:
  -- <Enter>e<Right>:   | Around 1st colon ( `key : value` ) | :'<,'>EasyAlign:<l1
  -- <Enter>e=          | Around 1st operators with =        | :'<,'>EasyAlign=
  -- <Enter>e3=         | Around 3rd operators with =        | :'<,'>EasyAlign3=
  -- <Enter>e*=         | Around all operators with =        | :'<,'>EasyAlign*=
  -- <Enter>e**=        | Left-right alternating around =    | :'<,'>EasyAlign**=
  -- <Enter>e<Enter>=   | Right alignment around 1st =       | :'<,'>EasyAlign!=
  -- <Enter>e<Enter>**= | Right-left alternating around =    | :'<,'>EasyAlign!**=
  ----------------------+------------------------------------+--------------------
  -- NOTE: Preceding the delimiter with a number X means "align around every Xth
  --       delimiter". Preceding the delimiter with a single `*` means "align
  --       around every occurrence of the delimiter." Two stars alternates
  --       between left-right alignment after each delimiter.
  --
  --       By default, EasyAlign will align around the first occurrence of the
  --       delimiter.
  -------------------------------------------------------------------------------
  --
  -------------------------------------------------------------------------------
  -- Indentation Option Settings:
  -------------------------------------------------------------------------------
  --       k       |       'keep'      |       Preserve existing indentation.
  -------------------------------------------------------------------------------
  --       d       |       'deep'      |       Use the indentation of the
  --               |                   |       most indented line.
  -------------------------------------------------------------------------------
  --       s       |       'shallow'   |       Use the indentation of the
  --               |                   |       least indented line.
  -------------------------------------------------------------------------------
  --       n       |       'none'      |       Left-align in-and-along the
  --               |                   |       left boundary of selected text.
  -------------------------------------------------------------------------------

  { -- Align things more easily! A bit more configurable than tabular.
    'junegunn/vim-easy-align',
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<cr>e', '<Plug>(EasyAlign)')
    end,
  },

  -- CONFIG_QUICKSCOPE
  { -- Highlight targets for character motions.
    'unblevable/quick-scope',
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end,
    config = function()
      vim.cmd('highlight link QuickScopePrimary SpecialChar')
      -- vim.cmd('highlight link QuickScopeSecondary Search')
    end,
  },

  -- CONFIG_VADER
  -- Test case framework for vim plugins.
  'junegunn/vader.vim',

  -- CONFIG_SIGNATURE
  -- Display marks in the sign column.
  'kshenoy/vim-signature',

  -- CONFIG_VIMWIKI
  -------------------------------------------------------------------------------
  --Configured partly using the following link as reference:
  --  https://www.dailydrip.com/blog/vimwiki
  -------------------------------------------------------------------------------
  --
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  --USAGE NOTES:
  --  If no [count] is specified, assume a count of one (1), unless otherwise
  --  noted.
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  --
  -------------------------------------------------------------------------------
  --OPENING WIKI:
  --  [count]<Leader>ww   OR  <Plug>VimwikiIndex
  --      Open the index of the [count]th wiki in g:vimwiki_list.
  --
  --  [count]<Leader>wt   OR  <Plug>VimwikiTabIndex
  --      Open the index of the [count]th wiki in g:vimwiki_list *in a new tab.*
  --
  --  <Leader>ws          OR  <Plug>VimwikiUISelect
  --      List and select available wikis in g:vimwiki_list.
  --
  --  [count]<Leader>wi   OR  <Plug>VimwikiDiaryIndex
  --      Open the diary index of the [count]th wiki in g:vimwiki_list.
  --
  --  [count]<Leader>w<Leader>w   OR  <Plug>VimwikiMakeDiaryNote
  --  [count]<Leader>w<Leader>t   OR  <Plug>VimwikiTabMakeDiaryNote
  --      Open a diary wiki-file for the current day in the [count]th wiki in
  --      g:vimwiki_list [in a new tab.]
  --
  --  [count]<Leader>w<Leader>y   OR  <Plug>VimwikiMakeYesterdayDiaryNote
  --  [count]<Leader>w<Leader>m   OR  <Plug>VimwikiMakeTomorrowDiaryNote
  --
  -------------------------------------------------------------------------------
  --NAVIGATION:
  --  <CR>                        Open or create a wiki link.
  --      :VimwikiSplitLink           Open/create a wiki link in a split.
  --      :VimwikiVSplitLink          Open/create a wiki link in a vertical split.
  --  <Backspace>                 Go back to previous wiki page.
  --  <Tab>                       Find next link in current page.
  --  <S-Tab>                     Find previous link in the current page.
  --
  --  DIARY:
  --      <C-Up>                  Open the previous day's diary.
  --      <C-Down>                Open the next day's diary.
  --
  -------------------------------------------------------------------------------
  --PAGE EDITING:
  --
  --  (these mappings have been disabled in ftplugin/vimwiki.vim)
  --  <Leader>wd                  Delete current wiki page.
  --      :VimwikiDeleteLink          // ditto
  --  <Leader>wr                  Rename current wiki page.
  --      :VimwikiRenameLink          // ditto
  --  (end notice)
  --
  --  [[                          Previous header in buffer.
  --  ]]                          Next header in buffer.
  --  [=                          Previous header with same level as selected.
  --  ]=                          Next header with same level as selected.
  --  ]u                          Go one header level 'up'.
  --  [u                          // ditto
  --  +                           Create and/or decorate links.
  --
  --  LISTS:
  --      glr                     Renumber list items.
  --      gLr                     Renumber all list items in the current file.
  --
  --      <C-d>                   (insert mode) Demote current list item.
  --      <C-t>                   (insert mode) Promote current list item.
  --
  -------------------------------------------------------------------------------
  --LINK FORMATTING:
  --  By default, links are specified with respect to the present working
  --  directory, similar to directory navigation in a bash terminal.
  --  - The '/' prefix (as in '/index') means 'relative to the wiki root.'
  --  - The '../' prefix (as in '../index') means 'relative to the parent
  --  directory.'
  --
  --  One can link to diary entries with the following scheme:
  --      [[diary:2012-03-05]]
  --
  --  Raw URLs are also supported, e.g.
  --      https://github.com/vimwiki/vimwiki.git
  --      mailto:billymagic@gmail.com
  --
  -------------------------------------------------------------------------------
  --TEXT ANCHORS:
  --  Section headings and tags can be used as text anchors.
  --  See `:h vimwiki-anchors`.
  --
  -------------------------------------------------------------------------------
  --MISCELLANY:
  --  - `:VimwikiTOC` creates a table of contents at the top of the current file.
  --  - vimwiki has tagbar support!
  -------------------------------------------------------------------------------

  -- { -- vimwiki, for my personal notes
  --   'vimwiki/vimwiki',
  --   config = function()
  --     vim.g.vimwiki_list = {
  --       path = home .. '/notes/',
  --       syntax = 'markdown',
  --       ext = '.md',
  --       index = 'README',
  --       auto_toc = 1,
  --     }
  --     vim.g.vimwiki_folding = 'expr'
  --     vim.g.vimwiki_global_ext = 0
  --     vim.keymap.set('n', '<C-Space>', '<Plug>VimwikiToggleListItem')
  --   end,
  -- },

  -- CONFIG_VIMTEX
  { -- vimtex, for compiling my resume
    'lervag/vimtex',
    init = function()
      -- Enable folding of documents by LaTeX structure.
      vim.g.vimtex_fold_enabled = 1

      -- Disable opening the quickfix window during continuous compilation.
      vim.g.vimtex_quickfix_enabled = 0

      -- ref: https://medium.com/@Pirmin/a-minimal-latex-setup-on-windows-using-wsl2-and-neovim-51259ff94734
      -- vim.g.vimtex_view_general_viewer = 'xdg-open'
      vim.g.vimtex_view_general_viewer = 'sumatraPDF'
      vim.g.vimtex_view_general_options = '-reuse-instance @pdf'

      -- Stop error messages on startup.
      vim.g.tex_flavor = 'latex'
    end,
  },

  -- CONFIG_JINJA
  -- Detect HTML and/or jinja2.
  'Glench/Vim-Jinja2-Syntax',

  -- CONFIG_TODO
  { -- highlight comments like TODO, NOTE, BUG
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- { -- File browser
  --     "nvim-neo-tree/neo-tree.nvim",
  --     branch = "v3.x",
  --     dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --       "MunifTanjim/nui.nvim",
  --     },
  --     config = function()
  --       require('neo-tree').setup({
  --         close_if_last_window = true,
  --         window = {
  --           mappings = {
  --             -- NOTE: this mapping below (1) doesn't work and (2) triggers an error
  --             -- message when showing neo-tree's help menu
  --             ["//"] = 'fuzzy-finder', -- don't shadow / for standard search
  --           },
  --         },
  --       })
  --       vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', {})
  --     end
  -- },

  -- CONFIG_NERDTREE
  { -- File browser, **Ol' Reliable**
    'preservim/nerdtree',
    config = function()
      -- Fix an apparent bug in NERDTree: <C-n> to toggle opening and closing
      -- NERDTree.
      vim.keymap.set('n', '<C-n>', function()
        if vim.fn.exists('b:NERDTree') == 1 then
          vim.cmd(':NERDTreeClose')
        else
          vim.cmd(':NERDTree' .. vim.fn.getcwd())
        end
      end, {})
      -- Close the tab if NERDTree is the only window remaining in it.
      -- vim.cmd([[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]])

      -- do it all in lua as a training exercise
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '*',
        -- NOTE: in lua, 0 is truthy, so we need the explicit `== 0` or `== 1`
        callback = function()
          if
            vim.fn.winnr('$') == 1
            and vim.fn.exists('b:NERDTree') == 1
            and vim.api.nvim_eval([[b:NERDTree.isTabTree()]]) == 1
          then
            -- and vim.api.nvim_call_dict_function(vim.b.NERDTree, 'isTabTree', {}) then
            vim.cmd('quit')
          end
        end,
      })
    end,
  },

  -- CONFIG_TMUX
  {
    'aserowy/tmux.nvim',
    config = function()
      require('tmux').setup({
        copy_sync = {
          -- enables copy sync. by default, all registers are synchronized.
          -- to control which registers are synced, see the `sync_*` options.
          enable = false,

          -- -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
          -- -- first buffer or named_buffer_name = true to ignore a named tmux
          -- -- buffer with name named_buffer_name :)
          -- ignore_buffers = { empty = false },
          --
          -- -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
          -- -- clipboard by tmux
          -- redirect_to_clipboard = false,
          --
          -- -- offset controls where register sync starts
          -- -- e.g. offset 2 lets registers 0 and 1 untouched
          -- register_offset = 0,
          --
          -- -- overwrites vim.g.clipboard to redirect * and + to the system
          -- -- clipboard using tmux. If you sync your system clipboard without tmux,
          -- -- disable this option!
          -- sync_clipboard = false,
          --
          -- -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
          -- sync_registers = true,
          --
          -- -- syncs deletes with tmux clipboard as well, it is adviced to
          -- -- do so. Nvim does not allow syncing registers 0 and 1 without
          -- -- overwriting the unnamed register. Thus, ddp would not be possible.
          -- sync_deletes = true,
          --
          -- -- syncs the unnamed register with the first buffer entry from tmux.
          -- sync_unnamed = true,
        },
        navigation = {
          -- cycles to opposite pane while navigating into the border
          cycle_navigation = true,

          -- enables default keybindings (C-hjkl) for normal mode
          enable_default_keybindings = true,

          -- prevents unzoom tmux when navigating beyond vim border
          persist_zoom = false,
        },
        resize = {
          -- enables default keybindings (A-hjkl) for normal mode
          enable_default_keybindings = false,

          -- -- sets resize steps for x axis
          -- resize_step_x = 1,
          --
          -- -- sets resize steps for y axis
          -- resize_step_y = 1,
        },
      })
    end,
  },

  -- CONFIG_SYNCOPATE
  {
    'google/vim-syncopate',
    dependencies = {
      'google/vim-maktaba',
    },
    config = function()
      -- vim.cmd('Glaive syncopate plugin[change_colorscheme]=false')
      vim.cmd('let g:html_number_lines = 0')
      vim.cmd('let g:syncopate = g:maktaba#plugin#Get("syncopate")')
      vim.cmd('call g:syncopate.Flag("change_colorscheme", 0)')
      vim.cmd('call g:syncopate.Flag("browser", "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe")')
    end,
  },

  -- CONFIG_LANGUAGE_SMARTS
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- CONFIG_NIO
  -- Dependency for nvim-dap-ui.
  {
    'nvim-neotest/nvim-nio',
  },

  -- CONFIG_FORMATTER
  { -- "Format runner" for neovim.
    'mhartington/formatter.nvim',
    config = function()
      local util = require('formatter.util')
      vim.keymap.set('n', '<leader>fff', ':FormatLock<cr>')
      require('formatter').setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require('formatter.filetypes.lua').stylua,
            --
            -- -- You can also define your own configuration
            -- function()
            --   -- Supports conditional formatting
            --   if util.get_current_buffer_file_name() == "special.lua" then
            --     return nil
            --   end
            --
            --   -- Full specification of configurations is down below and in Vim help
            --   -- files
            --   return {
            --     exe = "stylua",
            --     args = {
            --       "--search-parent-directories",
            --       "--stdin-filepath",
            --       util.escape_path(util.get_current_buffer_file_path()),
            --       "--",
            --       "-",
            --     },
            --     stdin = true,
            --   }
            -- end
          },
          c = {
            require('formatter.defaults.clangformat'),
          },
          cpp = {
            -- https://github.com/mhartington/formatter.nvim/blob/master/lua/formatter/filetypes/cpp.lua
            require('formatter.defaults.clangformat'),
            -- Above is equivalent to code below, which is copy-pasted from
            -- formatter.nvim/lua/formatter/defaults/clangformat.lua,
            --
            -- function()
            --   return {
            --       exe = "clang-format",
            --       args = {
            --           "-assume-filename",
            --           util.escape_path(util.get_current_buffer_file_name()),
            --         },
            --       stdin = true,
            --       try_node_modules = true,
            --     }
            -- end
          },

          css = {
            require('formatter.defaults.prettier'),
          },
          html = {
            require('formatter.defaults.prettier'),
          },
          xhtml = {
            require('formatter.defaults.prettier'),
          },
          javascript = {
            require('formatter.defaults.prettier'),
          },
          javascriptreact = {
            require('formatter.defaults.prettier'),
          },
          json = {
            require('formatter.defaults.prettier'),
          },
          python = {
            require('formatter.filetypes.python').yapf,
          },

          sql = {
            -- Supported dialects:
            -- ansi, athena, bigquery, clickhouse, databricks, db2, duckdb,
            -- exasol, greenplum, hive, materialize, mysql, oracle, postgres,
            -- redshift, snowflake, soql, sparksql, sqlite, teradata, trino, tsql
            function()
              return {
                exe = 'sqlfluff',
                args = {
                  'format',
                  '--dialect=oracle',
                  -- '--dialect=sqlite',
                },
              }
            end,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            --
            -- My configuration already strips trailing whitespace except for
            -- vader.vim files; this does it for all files, period.
            -- require("formatter.filetypes.any").remove_trailing_whitespace
          },
        },
      })
    end,
  },

  -- CONFIG_LINTERS
  -- Because even with LSP, sometimes linters just give better results.
  {
    'mfussenegger/nvim-lint',
    config = function()
      -- require('lint').setup({})
      require('lint').linters_by_ft = {
        python = { 'pylint', 'mypy', 'pycodestyle', 'pydocstyle' },
        sql = { 'sqlfluff' },
      }

      local sqlfluff = require('lint').linters.sqlfluff
      -- {
      --   args = { "lint", "--format=json", "--dialect=postgres" },
      --   cmd = "sqlfluff",
      --   ignore_exitcode = true,
      --   parser = <function 1>,
      --   stdin = false
      -- }
      -- sqlfluff.args = { "lint", "--format=json", "--dialect=oracle" }
      sqlfluff.args = { 'lint', '--format=json', '--dialect=sqlite' }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })

      -- TODO: declare command to Lint without writing?
    end,
  },

  -- CONFIG_WHICHKEY
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {
      delay = 200, -- Don't trigger on fast jk to exit insert/visual mode.
    },
  },

  -- CONFIG_GITSIGNS
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[g', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Git Hunk' })
        vim.keymap.set('n', ']g', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Git Hunk' })
        vim.keymap.set('n', 'gs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'Stage Hunk at Cursor' })
        vim.keymap.set(
          'n',
          'gu',
          require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = 'Undo Stage Hunk at Cursor' }
        )
        vim.keymap.set(
          'n',
          '<leader>ph',
          require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[P]review [H]unk' }
        )
      end,
    },
  },

  -- CONFIG_COLORSCHEME
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('onedark')
      -- Set this in vimrc
      -- vim.cmd('hi Normal ctermbg=None guibg=None')
    end,
  },

  -- CONFIG_HIGHLIGHTWHITESPACE
  {
    'lukoshkin/highlight-whitespace',
    opts = {
      tws = '\\s\\+$',
      clear_on_bufleave = false,
      palette = {
        markdown = {
          tws = 'RosyBrown',
          ['\\S\\@<=\\s\\(\\.\\|,\\)\\@='] = 'CadetBlue3',
          ['\\S\\@<= \\{2,\\}\\S\\@='] = 'SkyBlue1',
          ['\\t\\+'] = 'plum4',
        },
        other = {
          tws = 'PaleVioletRed',
          ['\\S\\@<=\\s,\\@='] = 'coral1',
          ['\\S\\@<=\\(#\\|--\\)\\@<! \\{2,3\\}\\S\\@=\\(#\\|--\\)\\@!'] = 'LightGoldenrod3',
          ['\\(#\\|--\\)\\@<= \\{2,\\}\\S\\@='] = '#3B3B3B',
          ['\\S\\@<= \\{3,\\}\\(#\\|--\\)\\@='] = '#3B3B3B',
          ['\\t\\+'] = 'plum4',
        },
      },
    },
  },
  -- CONFIG_LUALINE
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 2, -- absolute path
          },
        },
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 1, -- relative path
          },
        },
      },
      extensions = { 'fugitive', 'man', 'nerdtree', 'nvim-dap-ui' },
    },
  },

  -- CONFIG_MARKBAR
  {
    'Yilin-Yang/vim-markbar',
    -- dir = home .. '/plugins/vim-markbar',
    init = function()
      vim.g.markbar_enable_peekaboo = false
    end,
    config = function()
      vim.keymap.set('n', '<leader>m', '<Plug>ToggleMarkbar')
      vim.keymap.set('n', '<leader>rrr', '<Plug>ReadMarkbarRosters')
      vim.keymap.set('n', '<leader>www', '<Plug>WriteMarkbarRosters')
      vim.g.markbar_marks_to_display = '\'".^[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
      -- vim.g.markbar_peekaboo_marks_to_display = "'\".abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      vim.g.markbar_section_separation = 1
      vim.g.markbar_context_indent_block = ' '
      vim.g.markbar_width = 60
      -- vim.g.markbar_explicitly_remap_mark_mappings = true

      vim.g.markbar_force_clear_shared_data_on_delmark = true
      -- vim.g.markbar_persist_mark_names = false
      -- vim.g.markbar_print_time_on_shada_io = true
    end,
  },

  -- CONFIG_INDENTBLANKLINE
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = function()
      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg = '#56B6C2' })
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent5', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent6', { fg = '#C678DD' })
      end)

      require('ibl').setup({
        indent = {
          char = '┊',
          tab_char = '╏',
          highlight = {
            'IndentBlanklineIndent1',
            'IndentBlanklineIndent2',
            'IndentBlanklineIndent3',
            'IndentBlanklineIndent4',
            'IndentBlanklineIndent5',
            'IndentBlanklineIndent6',
          },
        },
      })
    end,
  },

  -- CONFIG_VISUALCOMMENT
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- CONFIG_REPLACEWITHREGISTER
  -- [count]["x]gr{motion}  to replace {motion} text with register x.
  -- [count]["x]grr         Replace [count] lines with the contents of
  --                        register x.
  -- ["x]gr$        to replace from the cursor position to the end of the line.
  -- {Visual}["x]gr to replace the selection with the contents of register x.
  { -- Make it easier to paste over things with the unnamed register.
    'vim-scripts/ReplaceWithRegister',
    init = function()
      vim.keymap.set('x', '<leader>r', '<Plug>ReplaceWithRegisterVisual')
    end,
  },

  -- CONFIG_LUASNIPS
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    config = function()
      local ls = require('luasnip')
      vim.keymap.set({ 'i' }, '<C-e>', function()
        ls.expand()
      end, { silent = true })
      vim.keymap.set({ 'i', 's' }, '<C-e>', function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ 'i', 's' }, '<C-b>', function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<C-c>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })

      require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
    end,
  },

  -- CONFIG_TELESCOPE
  -- Fuzzy Finder (files, lsp, etc)
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    -- By default, Telescope is included and acts as your picker for everything.

    -- If you would like to switch to a different picker (like snacks, or fzf-lua)
    -- you can disable the Telescope plugin by setting enabled to false and enable
    -- your replacement picker by requiring it explicitly (e.g. 'custom.plugins.snacks')

    -- Note: If you customize your config for yourself,
    -- it’s best to remove the Telescope plugin config entirely
    -- instead of just disabling it here, to keep your config clean.
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup({
        -- TODO: copy over new telescope features

        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<cr>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<cr>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<cr>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<cr>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<cr>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<cr>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<cr>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<cr>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<cr>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<cr>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<cr><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
      -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Find references for the word under your cursor.
          vim.keymap.set('n', '<cr>lsprr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

          -- Jump to the implementation of the word under your cursor.
          -- Useful when your language has ways of declaring types without an actual implementation.
          vim.keymap.set('n', '<cr>lspri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

          -- Jump to the definition of the word under your cursor.
          -- This is where a variable was first declared, or where a function is defined, etc.
          -- To jump back, press <C-t>.
          vim.keymap.set('n', '<cr>lsprd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

          -- Fuzzy find all the symbols in your current document.
          -- Symbols are things like variables, functions, types, etc.
          vim.keymap.set('n', '<cr>lspO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

          -- Fuzzy find all the symbols in your current workspace.
          -- Similar to document symbols, except searches over your entire project.
          vim.keymap.set(
            'n',
            '<cr>lspW',
            builtin.lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = 'Open Workspace Symbols' }
          )

          -- Jump to the type of the word under your cursor.
          -- Useful when you're not sure what type a variable is and you want to see
          -- the definition of its *type*, not where it was *defined*.
          vim.keymap.set('n', '<cr>lsprt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })

      -- Override default behavior and theme when searching
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files({ cwd = vim.fn.stdpath('config') })
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- CONFIG_LSPCONFIG
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        ---@diagnostic disable-next-line: missing-fields
        opts = {},
      },
      -- Maps LSP server names between nvim-lspconfig and Mason package names.
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<cr>lsprn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<cr>lspra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Go to the definition of a symbol.
          map('<cr>lspgd', vim.lsp.buf.definition, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('<cr>lspgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  See `:help lsp-config` for information about keys and how to configure
      ---@type table<string, vim.lsp.Config>
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},

        -- stylua = {}, -- Used to format Lua code

        -- Special Lua Config, as recommended by neovim help docs
        lua_ls = {
          on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
              then
                return
              end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                  '${3rd}/luv/library',
                  '${3rd}/busted/library',
                }),
              },
            })
          end,
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              format = { enable = false }, -- Disable formatting (formatting is done by stylua)
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- You can add other tools here that you want Mason to install
      })

      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },

  -- CONFIG_AUTOFORMAT
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fff',
        function()
          require('conform').format({ async = true })
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- You can specify filetypes to autoformat on save here:
        local enabled_filetypes = {
          -- lua = true,
          -- python = true,
        }
        if enabled_filetypes[vim.bo[bufnr].filetype] then
          return { timeout_ms = 500 }
        else
          return nil
        end
      end,
      default_format_opts = {
        lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
      },
      -- You can also specify external formatters in here.
      formatters_by_ft = {
        -- rust = { 'rustfmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- CONFIG_CMP
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  -- CONFIG_TREESITTER
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
    },
    build = {
      function(_)
        require('mason').setup({})
        -- TODO: This function is non-blocking; we want it to finish before
        -- TSUpdate runs. Leaving it as is, because a second boot of neovim will
        -- install the remaining parsers, and it takes hours to debug this.
        vim.cmd(':MasonInstall tree-sitter-cli')
      end,
      ':TSUpdate',
    },
    branch = 'main',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
      -- ensure basic parser are installed
      local parsers =
        { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based folds
        -- for more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

        -- enables treesitter based indentation
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require('nvim-treesitter').get_installed('parsers')

          if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require('nvim-treesitter').install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- CONFIG_KEYMAPS

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- If the quickfix window is open, double-tap Enter to close the which-key
-- window and jump to the listed line, but don't send a second Enter that would
-- put us one line too low.
vim.keymap.set('n', '<cr><cr>', function()
  if vim.api.nvim_get_option_value('buftype', {}) == 'quickfix' then
    return '<cr>'
  else
    return '<cr><cr>'
  end
end, { expr = true, replace_keycodes = true })

-- NOTE: Reuse platform-agnostic settings between vim and neovim. May clobber
-- settings from this file.
vim.cmd('source ~/.config/nvim/vimrc')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
