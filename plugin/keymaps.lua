-- CURSOR MOVEMENTS
vim.keymap.set('n', '<M-h>', function() vim.cmd.wincmd('h') end, { desc = 'Move to Left Window' })
vim.keymap.set('n', '<M-l>', function() vim.cmd.wincmd('l') end, { desc = 'Move to Right Window' })
vim.keymap.set('n', '<M-j>', function() vim.cmd.wincmd('j') end, { desc = 'Move to Bottom Window' })
vim.keymap.set('n', '<M-k>', function() vim.cmd.wincmd('k') end, { desc = 'Move to Upper Window' })

-- REMAP FOR DEALING WITH WORD WRAP
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- INSERT
vim.keymap.set('i', '<C-f>', '<Right>', { desc = 'Move Forward a Char' })
vim.keymap.set('i', '<C-b>', '<Left>', { desc = 'Move Backward a Char' })

-- DIAGNOSTIC
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Float Diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostics' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Loclist Diagnostics' })
