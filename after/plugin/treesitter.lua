require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'bibtex', 'comment', 'fish', 'gitignore',
		'latex', 'markdown', 'markdown_inline', 'python',
		'query', 'regex', 'swift',
	},
	-- auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = { 'latex' } },
	-- custom_captures = {
	-- 	['text.math.marker'] = 'Identifier',
	-- },
	incremental_selection = { enable = true },
	-- textobjects = { enable = true },
	indent = { enable = true },
	-- pairs = { enable = true },
	rainbow = { enable = true, extended_mode = false },
	playground = { enable = true },
	query_linter = { enable = true },
}

-- Folding
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
