-----------------------
-- TABLE OF CONTENTS --
-----------------------
-- CONFIG_DAP_UI
-- CONFIG_FORMATTER
-- CONFIG_GITSIGNS
-- CONFIG_UNIMPAIRED
-- CONFIG_TELESCOPE
-- CONFIG_TREESITTER
-- CONFIG_LSPCONFIG


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
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Actions for working in and around braces.
  'tpope/vim-surround',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Readline-style bindings on the vim command line.
  'tpope/vim-rsi',

  { -- Easier binds for resizing splits.
    'simeji/winresizer',
    config = function()
      vim.g.winresizer_keycode_finish = 100  -- finish by pressing 'd'
      vim.keymap.del('n', '<C-e>', {silent = true})
      vim.keymap.set('n', '<leader>wr', ':WinResizerStartResize<cr>', {desc = 'Start WinResizer'})
      vim.keymap.set('n', '<leader>wm', ':WinResizerStartMove<cr>', {desc = 'Start WinResizerMove'})
    end
  },

  -- :Delete, :Move, :Rename, Mkdir...
  'tpope/vim-eunuch',

  -- [[ CONFIG_UNIMPAIRED ]]
  -- ]q is cnext, [q is :cprevious, ]a is :next, [b is :bprevious...
  -- [<Space> (add line before current) and ]<Space> (add line after current)
  'tpope/vim-unimpaired',

  { -- Easy, intuitive two-way git diffs!
    -- Note: DiffConflictsShowHistory, if we need the three-way diff.
    'whiteinge/diffconflicts',
  },

  { -- Target and jump to a specific character,
    'easymotion/vim-easymotion',
    config = function()
      vim.keymap.set('n', '<localleader><localleader>', '<Plug>(easymotion-prefix)')
      vim.g.EasyMotion_smartcase = 1
    end
  },

  -- Local .vimrc settings.
  -- 'embear/vim-localvimrc',

  -- Repeat vim-surround commands using the period command.
  'tpope/vim-repeat',

--=============================================================================
--   vim-easy-align                                          [EASYALIGN]
--=============================================================================
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
-- <Enterx2><Space>    | Around 1st whitespaces             | :'<,'>EasyAlign\
-- <Enterx2>2<Space>   | Around 2nd whitespaces             | :'<,'>EasyAlign2\
-- <Enterx2>-<Space>   | Around the last whitespaces        | :'<,'>EasyAlign-\
-- <Enterx2>-2<Space>  | Around the 2nd to last whitespaces | :'<,'>EasyAlign-2\
-- <Enterx2>:          | Around 1st colon ( `key:  value` ) | :'<,'>EasyAlign:
-- <Enterx2><Right>:   | Around 1st colon ( `key : value` ) | :'<,'>EasyAlign:<l1
-- <Enterx2>=          | Around 1st operators with =        | :'<,'>EasyAlign=
-- <Enterx2>3=         | Around 3rd operators with =        | :'<,'>EasyAlign3=
-- <Enterx2>*=         | Around all operators with =        | :'<,'>EasyAlign*=
-- <Enterx2>**=        | Left-right alternating around =    | :'<,'>EasyAlign**=
-- <Enterx2><Enter>=   | Right alignment around 1st =       | :'<,'>EasyAlign!=
-- <Enterx2><Enter>**= | Right-left alternating around =    | :'<,'>EasyAlign!**=
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
      vim.keymap.set({'n', 'v'}, '<cr><cr>', '<Plug>(EasyAlign)')
    end,
  },

  { -- Highlight targets for character motions.
    'unblevable/quick-scope',
    init = function()
      vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    end,
    config = function()
      vim.cmd('highlight link QuickScopePrimary SpecialChar')
      -- vim.cmd('highlight link QuickScopeSecondary Search')
    end
  },

  -- Test case framework for vim plugins.
  'junegunn/vader.vim',

  -- Display marks in the sign column.
  'kshenoy/vim-signature',

--============================================================================
--  vimwiki                                                 [VIMWIKI]
--============================================================================
--
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
  --       path = '/home/yiliny/notes/',
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
    end
  },

  { -- highlight comments like TODO, NOTE, BUG
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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

  { -- File browser, **Ol' Reliable**
    'preservim/nerdtree',
    config = function()
      vim.keymap.set('n', '<C-n>', ':NERDTree<cr>', {})
      -- Close the tab if NERDTree is the only window remaining in it.
      -- vim.cmd([[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]])

      -- do it all in lua as a training exercise
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '*',
        -- NOTE: in lua, 0 is truthy, so we need the explicit `== 0` or `== 1`
        callback = function()
          if vim.fn.winnr('$') == 1 and vim.fn.exists('b:NERDTree') == 1
              and vim.api.nvim_eval([[b:NERDTree.isTabTree()]]) == 1 then
              -- and vim.api.nvim_call_dict_function(vim.b.NERDTree, 'isTabTree', {}) then
            vim.cmd('quit')
          end
        end
      })
    end
  },

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


    -- [[ CONFIG_DAP_UI ]]
  { -- Debug Adapter Protocol for in-editor debugging.
    -- Lifted from: https://www.reddit.com/r/neovim/comments/12wypuf/what_has_been_peoples_experience_with_nvimdap_or/jhjmdwu/
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()

      vim.cmd('hi clear debugPC')
      vim.cmd('hi link debugPC Underlined')

      -- don't *comment out* unused variables
      vim.cmd('hi link DiagnosticUnnecessary @variable')

      vim.keymap.set('n', '<cr>ddd', function()
        require('dapui').open()
        vim.cmd('DapContinue')  -- lazy-load nvim-dap
      end, { desc = 'Open nvim-dap UI' })

    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      'theHamsta/nvim-dap-virtual-text',
      'mfussenegger/nvim-dap-python',
    },
  },
  { -- Python DAP plugin
    'mfussenegger/nvim-dap-python',
    config = function()
      -- TODO: can we do /usr/bin/env python3?
      require('dap-python').setup('/usr/bin/python3')
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  { -- Show variable values inline with source code
    'theHamsta/nvim-dap-virtual-text',
    opts = {
      enabled = false,
      enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      -- show_stop_reason = true,               -- show stop reason when stopped for exceptions
      commented = false,                     -- prefix virtual text with comment string
      -- only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
      all_references = true,                 -- show virtual text on all all references of the variable (not only definitions)
    },
    config = function(_, opts)
      require('nvim-dap-virtual-text').setup(opts)
      vim.api.nvim_set_hl(0, 'NvimDapVirtualText', { link = 'DiagnosticInfo' })
      vim.api.nvim_set_hl(0, 'NvimDapVirtualTextChanged', { link = 'DiagnosticWarn' })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', { }
    },
  },

    -- [[ CONFIG_FORMATTER ]]
  { -- "Format runner" for neovim.
    'mhartington/formatter.nvim',
    config = function()
      local util = require('formatter.util')
      vim.keymap.set('n', '<leader><leader><leader>', ':FormatLock<cr>')
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
            require("formatter.filetypes.lua").stylua,
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

          cpp = {
            -- https://github.com/mhartington/formatter.nvim/blob/master/lua/formatter/filetypes/cpp.lua
            require("formatter.defaults.clangformat"),
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
            require("formatter.defaults.prettier"),
          },
          html = {
            require("formatter.defaults.prettier"),
          },
          xhtml = {
            require("formatter.defaults.prettier"),
          },
          javascript = {
            require("formatter.defaults.prettier"),
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            --
            -- My configuration already strips trailing whitespace except for
            -- vader.vim files; this does it for all files, period.
            -- require("formatter.filetypes.any").remove_trailing_whitespace
          },
        }
      })
    end,
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- [[ CONFIG_GITSIGNS ]]
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
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    -- Legacy vim configuration had working highlighting for trailing
    -- whitespace, but this is broken by navarasu/onedark.nvim. This plugin's
    -- highlighting, so use it as a workaround.
    'lukoshkin/highlight-whitespace',
    opts = {
      tws = '\\s\\+$',
      clean_on_winleave = true,
      user_palette = {
          markdown = {
            ['\\(\\S\\)\\@<=\\s\\(\\.\\|,\\)\\@='] = 'CadetBlue3',
            ['\\(\\S\\)\\@<= \\{2,\\}\\(\\S\\)\\@='] = 'SkyBlue1',
            ['\\t\\+'] = 'plum4',
          },
          other = {
            tws = 'PaleVioletRed',
            -- ['\\(\\S\\)\\@<=\\s\\(,\\)\\@='] = 'coral1',
            -- ['\\(\\S\\)\\@<= \\{2,\\}\\(\\S\\)\\@='] = 'LightGoldenrod3',
            -- ['\\t\\+'] = 'plum4',
          }
        },
    },
  },
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
    },
  },

  { -- Good old vim-markbar, for naming marks. Put this later to override
    -- which-key.
    'Yilin-Yang/vim-markbar',
    dir = '/home/yiliny/plugins/vim-markbar',
    init = function()
      vim.g.markbar_enable_peekaboo = false
    end,
    config = function()
      vim.keymap.set('n', '<leader>m', '<Plug>ToggleMarkbar')
      vim.keymap.set('n', '<leader>rrr', '<Plug>ReadMarkbarRosters')
      vim.keymap.set('n', '<leader>www', '<Plug>WriteMarkbarRosters')
      vim.g.markbar_marks_to_display = "'\".^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      -- vim.g.markbar_peekaboo_marks_to_display = "'\".abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      vim.g.markbar_section_separation = 0
      -- vim.g.markbar_explicitly_remap_mark_mappings = true

      vim.g.markbar_force_clear_shared_data_on_delmark = true
      -- vim.g.markbar_persist_mark_names = false
      vim.g.markbar_print_time_on_shada_io = true
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

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

  -- Fuzzy Finder (files, lsp, etc)
  { -- NOTE: that live grep won't work without BurntSushi/ripgrep installed:
    --  sudo apt install ripgrep
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
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
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

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

-- [[ CONFIG_TELESCOPE ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<cr>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<cr>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<cr>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<cr>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<cr>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<cr>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<cr>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<cr>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<cr>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ CONFIG_TREESITTER ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx',
                       'typescript', 'vimdoc', 'vim',  },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ CONFIG_LSPCONFIG ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<cr>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<cr>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('<cr>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<cr>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<cr>gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<cr>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<cr>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<cr>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<cr>K', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<cr>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<cr>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<cr>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.cmd('echomsg Formatted current buffer with LSP.')
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  -- gopls = {},
  pyright = {},
  pylsp = {},
  -- rust_analyzer = {},
  html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  dockerls = {},
  eslint = {},
  tsserver = {},
  jsonls = {},
  vimls = {},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete{},
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },
    ['<Tab>'] = cmp.mapping(function(fallback)
      -- if cmp.visible() then
      --   cmp.select_next_item()
      -- elseif luasnip.expand_or_locally_jumpable() then
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      -- if cmp.visible() then
      --   cmp.select_prev_item()
      -- elseif luasnip.locally_jumpable(-1) then
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Additional Debug Adapter Protocol configuration

local dap = require('dap')
-- Uncommenting this would clobber all four of nvim-dap-python's default
-- configurations, which were: (1) Launch, (2) Launch with arguments,
-- (3) Attach remote, and (4) Run doctests in file.
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = function()
--       return '/usr/bin/python'
--     end;
--   },
-- }
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14',
  name = 'lldb'
}

-- For this to work, lldb-vscode-XX must be in $PATH.
dap.configurations.cpp = {
  {
    name = 'Launch an executable',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
  {
    name = 'Launch an executable with arguments',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, " +")
    end,
  },
}

vim.keymap.set("n", "<cr>d<cr>", ":DapContinue<CR>")
vim.keymap.set("n", "<cr>dl", ":DapStepInto<CR>")
vim.keymap.set("n", "<cr>dj", ":DapStepOver<CR>")
vim.keymap.set("n", "<cr>dh", ":DapStepOut<CR>")

vim.keymap.set("n", "<cr>dbt", function()
  require('dap').toggle_breakpoint()
end, { desc = '[B]reakpoint [T]toggle' } )

vim.keymap.set("n", "<cr>dbc", function()
  require('dap').toggle_breakpoint(vim.fn.input('Enter breakpoint condition: '))
end, { desc = '[B]reakpoint with [C]ondition' } )

vim.keymap.set({'n', 'v'}, '<cr>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<cr>dp', function()
  require('dap.ui.widgets').preview()
end)

vim.keymap.set('n', '<cr>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = '[D]ebug [F]rames in centered float' })

vim.keymap.set('n', '<cr>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = '[D]ebug [S]copes in centered float' })

vim.keymap.set("n", "<cr>dz", ":ZoomWinTabToggle<CR>")

vim.keymap.set(
    "n",
    "<cr>dgt",  -- dg as in debu[g] [t]race
    ":lua require('dap').set_log_level('TRACE')<CR>"
)
vim.keymap.set(
    "n",
    "<cr>dge",  -- dg as in debu[g] [e]dit
    function()
        vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
    end
)
vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
vim.keymap.set("n", "<F4>", ":DapContinue<CR>")
vim.keymap.set(
    "n",
    "<cr>d-",
    function()
        require("dap").restart()
    end
)
vim.keymap.set(
    "n",
    "<cr>d_",
    function()
        require("dap").terminate()
        require("dapui").close()
    end
)

-- NOTE: Reuse platform-agnostic settings between vim and neovim. May clobber
-- settings from this file.
vim.cmd('source ~/.config/nvim/vimrc')


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
