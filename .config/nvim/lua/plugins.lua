vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
      'nvim-telescope/telescope.nvim', version = '*',
      dependencies = {
          'nvim-lua/plenary.nvim',
          { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      }
  }

  use { "ellisonleao/gruvbox.nvim" }

  use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
          "nvim-treesitter/playground",
      },
      build = ":TSUpdate",
      lazy = false,
  }

  use 'nvim-treesitter/playground'

  use 'mbbill/undotree'

  use 'tpope/vim-fugitive'


  ----------------
  -- LSP stuff

  use {
      'neovim/nvim-lspconfig',
      tag = 'v1.8.0',
      pin = true,
      opts = {
      }
  }
  use {'mason-org/mason.nvim', tag = 'v1.11.0', pin = true}
  use {'mason-org/mason-lspconfig.nvim', tag = 'v1.32.0', pin = true}

  -- Autocompletion
  use {
      "hrsh7th/nvim-cmp",
      requires = {
          "jcha0713/cmp-tw2css",
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-nvim-lsp',
          'saadparwaiz1/cmp_luasnip',
          "hrsh7th/cmp-calc",
          "davidsierradz/cmp-conventionalcommits",
          "ray-x/cmp-sql",
          'hrsh7th/cmp-nvim-lua',
          {
              "ogaken-1/cmp-tsnip",
              requires = {
                  "vim-denops/denops.vim"
              }
          },
      },
  }

  -- Snippets
  use	  {'L3MON4D3/LuaSnip'}
  use	  {'rafamadriz/friendly-snippets'}

  -- End of LSP stuff
  ----------------

  use 'preservim/nerdtree'

  use 'tomtom/tcomment_vim'

  use {
      'MunifTanjim/prettier.nvim',
      requires = {
          {'neovim/nvim-lspconfig'},
          {'MunifTanjim/prettier.nvim'}
      }
  }

  use 'sbdchd/neoformat'

  use 'ryanoasis/vim-devicons'

  use 'ntpeters/vim-better-whitespace'

  use 'fatih/vim-go'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
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

  use {
      "nvim-neotest/neotest",
      requires = {
          "nvim-neotest/nvim-nio",
          "nvim-lua/plenary.nvim",
          "antoinemadec/FixCursorHold.nvim",
          "nvim-neotest/neotest-go",
      },
      config = function()
          local neotest_ns = vim.api.nvim_create_namespace("neotest")
          vim.diagnostic.config({
              virtual_text = {
                  format = function(diagnostic)
                      local message =
                      diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                      return message
                  end,
              },
          }, neotest_ns)
      end,
  }

  use 'wellle/context.vim'

  use 'tomasky/bookmarks.nvim'

  use 'voldikss/vim-floaterm'

  use 'sangdol/mintabline.vim'

  use 'romainl/vim-qf'

  -- use 'sphamba/smear-cursor.nvim'

  use {
      'mvllow/modes.nvim',
      tag = 'v0.2.1',
      config = function()
          require('modes').setup()
      end
  }

  use 'onsails/lspkind.nvim'
end)
