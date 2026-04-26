local telescope = require('telescope')

local builtin = require('telescope.builtin')
telescope.setup {
    pickers = {
        find_files = {
            hidden = true
        }
    },
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { " " },
    },
}

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', function()
builtin.grep_string({search = vim.fn.input("Find > ")});
end)
vim.keymap.set('n', '<leader>w', builtin.buffers)
vim.keymap.set('n', '<leader>gd', function() require('telescope.builtin').lsp_references() end, { noremap = true, silent = true })

-- require('telescope').load_extension("ag")
