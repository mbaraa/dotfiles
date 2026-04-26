vim.cmd([[
:vnoremap <leader>d64 c<c-r>=system('base64 --decode', @")<cr><esc>
]])

vim.cmd([[
:vnoremap <leader>64 c<c-r>=system('base64', @")<cr><esc>
]])
