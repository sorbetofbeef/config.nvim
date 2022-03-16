require('session_manager').setup {
	autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
}

local sc = require('session_manager.commands')

vim.keymap.set('n', '<leader>sd', function()
	sc.run_command('delete_session')
end, { desc = 'Select and delete session' })
vim.keymap.set('n', '<leader>sl', function()
	sc.run_command('load_last_session')
end, { desc = 'Restore last session' })
vim.keymap.set('n', '<leader>sr', function()
	sc.run_command('load_session')
end, { desc = 'Select and load session' })
vim.keymap.set('n', '<leader>ss', function()
	sc.run_command('save_current_session')
	vim.notify('Current Session Saved', 'info', { title = 'Session Manager' })
end, { desc = 'Save current session' })