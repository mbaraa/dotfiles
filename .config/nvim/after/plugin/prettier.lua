local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "go",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "lua",
    "markdown",
    "rust",
    "scss",
    "svelte",
    "sveltekit",
    "templ",
    "typescript",
    "typescriptreact",
    "yaml",
  },
});

local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

autocmd('BufWritePre', {
  pattern = '',
  command = ":Neoformat"
})

autocmd('BufWritePost', {
    pattern = "*.rs",
    command = ":silent! !rustfmt % --edition=2021"
})

autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})
