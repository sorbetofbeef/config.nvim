local M = {
	'nvim-neorg/neorg',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- 'nvim-neorg/neorg-telescope'
	},
	ft = 'norg',
}

-- function M.build()
-- 	pcall(require('nvim-treesitter.install').commands.TSInstallSync['run!']('norg', 'norg_meta'))
-- end

M.config = {
	load = {
		['core.defaults'] = {},
		['core.keybinds'] = {},
		['core.norg.concealer'] = {},
		['core.norg.dirman'] = {
			config = {
				workspaces = {
					gtd  = '~/Documents/neorg/gtd/',
					work = '~/Documents/neorg/work/',
				},
			},
		},
		['core.gtd.base'] = { config = { workspace = 'gtd' } },
		['core.gtd.ui'] = {},
		['core.norg.completion'] = { config = { engine = 'nvim-cmp' } },
		['core.norg.qol.toc'] = {},
		-- ['core.integrations.telescope'] = {},
	},
}

return M
