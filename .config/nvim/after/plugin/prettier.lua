local prettier = require("prettier")

prettier.setup({
  bin = 'prettierd', -- or `'prettierd'` (v0.22+)
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
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

vim.api.nvim_create_autocmd("BufWritePre *", {
	command = "Neoformat"
})
