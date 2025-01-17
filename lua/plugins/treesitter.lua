return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "HiPhish/nvim-ts-rainbow2" },
	config = function(_, opts)
		-- Folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldenable = false

		require("nvim-treesitter.configs").setup(opts)
	end,
	opts = {
		ensure_installed = {
			"bash",
			"bibtex",
			"c",
			"comment",
			"diff",
			"fish",
			"git_rebase",
			"gitcommit",
			"gitignore",
			"help",
			"latex",
			"lua",
			"markdown",
			"markdown_inline",
			"matlab",
			"norg",
			"python",
			"query",
			"regex",
			"swift",
			"vim",
		},
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		rainbow = {
			enable = true,
			query = { latex = "rainbow-parens" },
		},
	},
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
}
