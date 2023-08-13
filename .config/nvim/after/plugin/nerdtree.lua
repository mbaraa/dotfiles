vim.keymap.set("n", "<F5>", vim.cmd.NERDTreeToggle)

-- open nerd tree on startup
vim.api.nvim_create_autocmd("VimEnter", {
	command = "NERDTree"
})

-- close nerd tree when file closes
vim.api.nvim_create_autocmd("bufenter", {
	command = 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	command = "NERDTreeMirror"
})

vim.g.NERDTreeShowHidden = 1
