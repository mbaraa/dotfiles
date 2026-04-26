-- Create a new augroup
vim.api.nvim_create_augroup('custom_qf_mapping', { clear = true })

-- Define autocmds within the augroup
vim.api.nvim_create_autocmd('FileType', {
    group = 'custom_qf_mapping',
    pattern = 'qf',
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'dd', ':.Reject<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, 'x', 'd', ":'<,'>Reject<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, 'n', 'gk', ':.Keep<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, 'x', 'gk', ":'<,'>Keep<CR>", { noremap = true, silent = true })
    end
})
