vim.api.nvim_create_autocmd("VimEnter", {
	command = "set number relativenumber"
})

vim.keymap.set("n", "<F3>", ":set number! relativenumber!<CR>")
