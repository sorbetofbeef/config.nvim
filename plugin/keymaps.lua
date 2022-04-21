-- CURSOR MOVEMENTS
vim.keymap.set('n', '<M-h>', '<cmd>wincmd h<CR>', { desc = 'Move to Left Window' })
vim.keymap.set('n', '<M-l>', '<cmd>wincmd l<CR>', { desc = 'Move to Right Window' })
vim.keymap.set('n', '<M-j>', '<cmd>wincmd j<CR>', { desc = 'Move to Bottom Window' })
vim.keymap.set('n', '<M-k>', '<cmd>wincmd k<CR>', { desc = 'Move to Upper Window' })
-- REMAP FOR DEALING WITH WORD WRAP
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- BUFFER NAVIGATION
vim.keymap.set('n', '<leader>bp', '<Cmd>bprev<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>bn', '<Cmd>bnext<CR>', { desc = 'Next Buffer' })
-- INSERT
vim.keymap.set('i', '<C-f>', '<Right>', { desc = 'Move Forward a Char' })
vim.keymap.set('i', '<C-b>', '<Left>', { desc = 'Move Backward a Char' })

-- BETTER UNDO
-- vim.keymap.set('i', ',', ',<c-g>u')
-- vim.keymap.set('i', '!', '!<c-g>u')
-- vim.keymap.set('i', '.', '.<c-g>u')
-- vim.keymap.set('i', ' ', ' <c-g>u')
-- vim.keymap.set('i', '?', '?<c-g>u')
-- vim.keymap.set('i', '_', '_<c-g>u')
-- vim.keymap.set('i', '<CR>', '<CR><c-g>u')
