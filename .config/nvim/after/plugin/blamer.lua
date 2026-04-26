-- open blamer on startup
vim.api.nvim_create_autocmd("VimEnter", {
	command = "BlamerShow"
})

vim.g.blamer_delay = 2000
vim.g.blamer_show_in_insert_modes = 0
