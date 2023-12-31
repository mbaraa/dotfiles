vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
      "kelly-lin/telescope-ag",
      requires = { "nvim-telescope/telescope.nvim" },
  })

  use { "ellisonleao/gruvbox.nvim" }

  use ('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})

  use 'nvim-treesitter/playground'

  use 'mbbill/undotree'

  use 'tpope/vim-fugitive'

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }

  use 'preservim/nerdtree'

  use 'tomtom/tcomment_vim'

  use 'MunifTanjim/prettier.nvim'

  use 'sbdchd/neoformat'

  use 'ryanoasis/vim-devicons'

  use 'ntpeters/vim-better-whitespace'

  use 'fatih/vim-go'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
          require("todo-comments").setup {
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  }

  use {
      'filipdutescu/renamer.nvim',
      branch = 'master',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'mattreduce/vim-mix'
  use 'carlosgaldino/elixir-snippets'

  use 'eandrju/cellular-automaton.nvim'

  use 'APZelos/blamer.nvim'

end)
