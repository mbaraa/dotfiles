vim.api.nvim_create_autocmd("WinEnter", {
	command = "set cursorline cursorcolumn"
})

vim.api.nvim_create_autocmd("WinLeave", {
	command = "set nocursorline nocursorcolumn"
})
