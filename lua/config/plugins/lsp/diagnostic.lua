local fn = vim.fn

-- Diagnostic signs
fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Float Diagnostics' })
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostics' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Loclist Diagnostics' })