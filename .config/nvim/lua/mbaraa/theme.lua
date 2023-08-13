vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")

-- 0 is for global space
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "Float", {bg = "none"})
