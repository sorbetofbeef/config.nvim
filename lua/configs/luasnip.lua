local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.setup {
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = { virt_text = { { '●', 'DiagnosticSignHint' } } },
		},
	},
}

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { desc = 'LuaSnip Forward Jump' })
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { desc = 'LuaSnip Backward Jump' })
vim.keymap.set({ 'i', 's' }, '<C-l>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { desc = 'LuaSnip Next Choice' })

local snippets_clear = function()
	for m, _ in pairs(ls.snippets) do
		package.loaded['snippets.' .. m] = nil
	end
	ls.snippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, 'snippets.' .. k)
			if not ok and not string.match(m, '^module.*not found:') then
				error(m)
			end
			t[k] = ok and m or {}

			return t[k]
		end,
	})
end

local autosnippets_clear = function()
	for m, _ in pairs(ls.snippets) do
		package.loaded['autosnippets.' .. m] = nil
	end
	ls.autosnippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, 'autosnippets.' .. k)
			if not ok and not string.match(m, '^module.*not found:') then
				error(m)
			end
			t[k] = ok and m or {}

			return t[k]
		end,
	})
end

snippets_clear()
autosnippets_clear()

vim.api.nvim_create_augroup('snippets_clear', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	callback = snippets_clear,
	pattern = '~/.config/nvim/lua/snippets/*.lua',
	group = 'snippets_clear',
	desc = 'Reload snippets whenever they are updated',
})
vim.api.nvim_create_autocmd('BufWritePost', {
	callback = autosnippets_clear,
	pattern = '~/.config/nvim/lua/autosnippets/*.lua',
	group = 'snippets_clear',
	desc = 'Reload autosnippets whenever they are updated',
})

-- local edit_ft = function()
-- 	-- returns table like {"lua", "all"}
-- 	local fts = require('luasnip.util.util').get_snippet_filetypes()
-- 	vim.ui.select(fts, {
-- 		prompt = 'Select which filetype to edit:',
-- 	}, function(item, idx)
-- 		-- selection aborted -> idx == nil
-- 		if idx then
-- 			vim.cmd('edit ~/.config/nvim/lua/snippets/' .. item .. '.lua')
-- 		end
-- 	end)
-- end

-- vim.api.nvim_add_user_command('LuaSnipEdit', edit_ft, {})
