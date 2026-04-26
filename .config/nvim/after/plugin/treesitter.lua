-- require('nvim-treesitter.config').setup {
--   ensure_installed = { "lua", "rust", "toml", "c", "cpp", "go", "elixir", "typescript", "javascript", "vim", "json", "html", "css", "svelte", "templ" },
--   auto_install = true,
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting=false,
--   },
--   ident = { enable = true },
--   rainbow = {
--     enable = true,
--     extended_mode = true,
--     max_file_lines = nil,
--   }
-- }

local treesitter = require("nvim-treesitter")
vim.opt.runtimepath:append(',~/.local/share/nvim/site/')
treesitter.setup()
treesitter.install { "lua", "rust", "toml", "c", "cpp", "go", "elixir", "typescript", "javascript", "vim", "json", "html", "css", "svelte", "templ", "yaml", "tsx", "jsx", "python" }

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "lua", "rust", "toml", "c", "cpp", "go", "elixir", "typescript", "javascript", "vim", "json", "html", "css", "svelte", "templ", "yaml", "tsx", "jsx", "python" },
    callback = function()
        vim.treesitter.start()
        -- folds, provided by Neovim (I don't like folds)
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

