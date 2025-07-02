-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'

  -- ui
  use 'folke/tokyonight.nvim'
  use {
    'nvim-lualine/lualine.nvim',
  }

  -- cmp
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'

  -- golang
  use 'ray-x/go.nvim'

  -- gui
   use 'ray-x/guihua.lua'
  -- gui navigator for showing refernece, definition, and so on
   use({
     'ray-x/navigator.lua',
     requires = {
         { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
         { 'neovim/nvim-lspconfig' },
     },
   })

  -- fuzzy search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
		{'nvim-lua/plenary.nvim'},
		{"nvim-telescope/telescope-live-grep-args.nvim"},
	},
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("live_grep_args")
    end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-frecency.nvim" }

  -- file tree
  use {
    'nvim-tree/nvim-tree.lua',
  }

  use 'vim-test/vim-test'

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'leoluz/nvim-dap-go'
  -- FIXME: reenable this plugin after it is fixed
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { 'nvim-telescope/telescope-dap.nvim' }
  use 'theHamsta/nvim-dap-virtual-text'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }


  -- window management
  -- use 't9md/vim-choosewin'
  use 'simeji/winresizer'

  -- auto pair
  use 'windwp/nvim-autopairs'
  --use "steelsojka/pears.nvim"
  -- Simple plugins can be specified as strings
  -- use 'rstacruz/vim-closer'


  -- quickfix list
  -- use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  -- outliner
  use 'simrat39/symbols-outline.nvim'

  -- blamer
  use 'APZelos/blamer.nvim'

  -- better diagnostics visual text
  -- not use because navigator.nvim can handle this
  -- use({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- })

  -- clipboard through ssh
  use 'ojroques/vim-oscyank'

  -- harpoon for marking files
  -- use 'nvim-lua/plenary.nvim' 
  -- use 'ThePrimeagen/harpoon'

  -- trouble vim
  use {
    "folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- diff view
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- open alternate files
  -- disabled because it's hard to define the "other" files
  -- use 'rgroli/other.nvim'

  -- yaml foldding
  use 'pedrohdz/vim-yaml-folds'

  -- bookmark
  -- use 'ldelossa/litee.nvim'
  -- use 'ldelossa/litee-bookmarks.nvim'
  -- use 'MattesGroeger/vim-bookmarks'
  -- use 'tom-anders/telescope-vim-bookmarks.nvim'

  -- for getting hint when typing out a function
  use {
    "ray-x/lsp_signature.nvim",
  }

  -- network filemanager
  -- use {
  --   'stevearc/oil.nvim',
  --   config = function() require('oil').setup() end
  -- }
  use 'nvim-tree/nvim-web-devicons'

  -- don't push me
  use 'sso://googler@user/vintharas/telescope-codesearch.nvim'
  use 'sso://googler@user/jackcogdill/nvim-figtree'
  use 'sso://googler@team/neovim-dev/neocitc'
  use 'sso://googler@user/cnieves/critique-nvim'
  use 'sso://googler@user/vintharas/goog-terms.nvim'
  use  {
      'sso://googler@user/cassc/nvim-fmtserver',
      dependencies = {
    	  'sso://googler@user/cassc/nvim-stubby',
    	  'sso://googler@user/cassc/nvim-tree-sitter-text-proto',
    	  'nvim-lua/plenary.nvim'
      }
  }
  use "sso://googler@user/vintharas/avante-goose.nvim"

  -- use {
  --   'kiddos/gemini.nvim',
  --   config = function()
  --     require('gemini').setup()
  --   end,
  -- }

  -- Required plugins
  use 'stevearc/dressing.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'

  -- Optional dependencies
  use 'HakonHarnes/img-clip.nvim'
  use 'zbirenbaum/copilot.lua'
  use "ibhagwan/fzf-lua"

  -- Avante.nvim with build process
  use {
    'yetone/avante.nvim',
    branch = 'main', -- fix/compatible-with-gemini',
    run = 'make',
    config = function()
      require('avante_lib').load()
    end
  }

  use {
    'polarmutex/git-worktree.nvim',
    version = '^2',
    dependencies = { "nvim-lua/plenary.nvim" }
  }

  use {
    'ggandor/leap.nvim',
    dependencies = { "tpope/vim-repeat" }
  }

  use 'yorickpeterse/nvim-window'

  use({
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup()
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
