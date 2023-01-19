return {

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "mathjiajia/mysnippets" },
		config = function(_, opts)
			local ls = require("luasnip")
			ls.setup(opts)

			require("luasnip.loaders.from_lua").lazy_load({
				paths = vim.fn.stdpath("data") .. "/lazy/mySnippets/snippets",
			})

			-- stylua: ignore start
			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.expandable() or ls.locally_jumpable(1) then ls.expand_or_jump() end
			end, { desc = "LuaSnip Forward Jump" })

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if ls.locally_jumpable(-1) then ls.jump(-1) end
			end, { desc = "LuaSnip Backward Jump" })

			vim.keymap.set("i", "<C-l>", function()
				if ls.choice_active() then ls.change_choice(1) end
			end, { desc = "LuaSnip Next Choice" })
			-- stylua: ignore end
		end,
		opts = function()
			local types = require("luasnip.util.types")
			return {
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
				ext_opts = { [types.choiceNode] = { active = { virt_text = { { "« ", "NonText" } } } } },
			}
		end,
	},

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"lukas-reineke/cmp-rg",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
		end,
		opts = function()
			local cmp = require("cmp")
			local cmp_kinds = require("config").icons.cmp_kinds

			return {
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.kind = cmp_kinds[vim_item.kind]
						vim_item.menu = ({
							buffer = "[Buf]",
							cmdline = "[Cmd]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							neorg = "[Norg]",
							path = "[Path]",
							rg = "[RG]",
						})[entry.source.name]
						return vim_item
					end,
				},
				matching = { disallow_prefix_unmatching = true },
				sources = {
					{ name = "nvim_lsp", max_item_count = 10 },
					{ name = "luasnip", max_item_count = 10, option = { show_autosnippets = true } },
					{ name = "neorg", max_item_count = 5 },
					{ name = "buffer", keyword_length = 3, max_item_count = 10 },
					-- { name = "copilot", max_item_count = 3 },
					{ name = "path", keyword_length = 4, max_item_count = 5 },
					{ name = "rg", keyword_length = 4, max_item_count = 8 },
				},
				window = {
					completion = { border = "rounded", col_offset = -3 },
					documentation = { border = "rounded" },
				},
			}
		end,
		event = { "CmdlineEnter", "InsertEnter" },
	},

	-- github copilot
	{
		"zbirenbaum/nvim-copilot",
		enabled = false,
		dependencies = { "zbirenbaum/copilot_cmp", config = true },
		opts = {
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node",
			server_opts_overrides = {},
		},
		event = "InsertEnter",
		cmd = "Copilot",
	},

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup()

			-- turn off the quotes rule for LaTeX
			npairs.get_rule("'")[1].not_filetypes = { "tex", "latex" }
			npairs.get_rule('"')[1].not_filetypes = { "tex", "latex" }

			-- add new rules for LaTeX
			npairs.add_rules({ Rule("`", "'", { "tex", "latex" }) })
			npairs.add_rules({ Rule("``", "'", { "tex", "latex" }) }) -- tricky
			npairs.add_rules({ Rule("\\(", "\\)", { "tex", "latex" }) })
			npairs.add_rules({ Rule("\\[", "\\]", { "tex", "latex" }) })
		end,
		event = "InsertEnter",
	},

	-- surround
	{
		"kylechui/nvim-surround",
		config = true,
		keys = { "cs", "ds", "ys", "yS" },
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		config = true,
		keys = {
			{ "gcc", mode = "n" },
			{ "gbc", mode = { "n", "x" } },
			{ "gc", mode = { "n", "x" } },
		},
	},

	-- better text-objects
	{
		"echasnovski/mini.ai",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- no need to load the plugin, since we only need its queries
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		config = function(_, opts)
			local ai = require("mini.ai")
			ai.setup(opts)
		end,
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
	},
}
