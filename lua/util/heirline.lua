-- local opts = {}

local api, fn = vim.api, vim.fn

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local devicons = require("nvim-web-devicons")
local util = require("util")

local colors = {
	bright_bg = utils.get_highlight("Folded").bg,
	-- bright_fg  = utils.get_highlight('Folded').fg,
	red = utils.get_highlight("DiagnosticError").fg,
	dark_red = utils.get_highlight("DiffDelete").bg,
	green = utils.get_highlight("String").fg,
	blue = utils.get_highlight("Function").fg,
	gray = utils.get_highlight("NonText").fg,
	orange = utils.get_highlight("Constant").fg,
	purple = utils.get_highlight("Statement").fg,
	cyan = utils.get_highlight("Special").fg,
	diag_warn = utils.get_highlight("DiagnosticWarn").fg,
	diag_error = utils.get_highlight("DiagnosticError").fg,
	diag_hint = utils.get_highlight("DiagnosticHint").fg,
	diag_info = utils.get_highlight("DiagnosticInfo").fg,
	git_del = utils.get_highlight("Error").fg,
	git_add = utils.get_highlight("Comment").fg,
	git_change = utils.get_highlight("Function").fg,
	work_dir = utils.get_highlight("Directory").fg,
}

require("heirline").load_colors(colors)

local LeftCap = {
	provider = "▌",
	hl = { fg = "fg" },
}

local VimModeNormal = {
	condition = function(self)
		return self.mode == "n"
	end,

	provider = " ●",
	hl = { fg = "fg" },
}

local VimModeOthers = {
	condition = function(self)
		return self.mode ~= "n"
	end,

	static = {
		modes = {
			v = { "VISUAL", "cyan" },
			V = { "V-LINE", "cyan" },
			["\22"] = { "V-BLCK", "cyan" },
			s = { "SELECT", "purple" },
			S = { "S-LINE", "purple" },
			["\19"] = { "S-BLCK", "purple" },
			i = { "INSERT", "blue" },
			R = { "RPLACE", "green" },
			c = { "CMMAND", "green" },
			r = { "...", "orange" },
			["!"] = { "SHELL", "red" },
			t = { "TERM", "red" },
		},
	},

	utils.surround({ "", "" }, function(self)
		return self.modes[self.mode][2]
	end, {
		{
			provider = function(self)
				return "● " .. self.modes[self.mode][1]
			end,
		},
		hl = function(self)
			return { fg = "bg", bg = self.modes[self.mode][2] }
		end,
	}),
}

local VimMode = {
	init = function(self)
		self.mode = fn.mode()
	end,

	VimModeNormal,
	VimModeOthers,

	update = { "ModeChanged" },
}

local Snippets = {
	condition = function()
		return vim.tbl_contains({ "i", "s" }, fn.mode())
	end,
	provider = function()
		local ls = require("luasnip")
		local forward = ls.locally_jumpable(1) and "" or ""
		local backward = ls.locally_jumpable(-1) and " " or ""
		return backward .. forward
	end,
	hl = { fg = "red", bold = true },
}

local WorkDir = {
	init = function(self)
		self.icon = (fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
		local cwd = fn.getcwd(0)
		self.cwd = fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#self.cwd, 0.27) then
			self.cwd = fn.pathshorten(self.cwd)
		end
	end,
	hl = { fg = "blue", bold = true },
	on_click = {
		callback = function()
			require("neo-tree.command").execute({ dir = util.get_root() })
		end,
		name = "heirline_workdir",
	},

	flexible = 1,
	{
		provider = function(self)
			local trail = self.cwd:sub(-1) == "/" and "" or "/"
			return self.icon .. self.cwd .. trail .. " "
		end,
	},
	{
		provider = function(self)
			local cwd = fn.pathshorten(self.cwd)
			local trail = self.cwd:sub(-1) == "/" and "" or "/"
			return self.icon .. cwd .. trail .. " "
		end,
	},
	-- { provider = "" },
}

local FileNameBlock = {
	init = function(self)
		self.filename = api.nvim_buf_get_name(0)
	end,
}

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileName = {
	init = function(self)
		self.lfilename = fn.fnamemodify(self.filename, ":.")
		if self.lfilename == "" then
			self.lfilename = "[No Name]"
		end
		if not conditions.width_percent_below(#self.lfilename, 0.27) then
			self.lfilename = fn.pathshorten(self.lfilename)
		end
	end,
	hl = "Directory",
	flexible = 2,
	{
		provider = function(self)
			return self.lfilename
		end,
	},
	{
		provider = function(self)
			return fn.pathshorten(self.lfilename)
		end,
	},
}

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+]",
		hl = { fg = "green" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = "",
		hl = { fg = "orange" },
	},
}

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			return { fg = "cyan", bold = true, force = true }
		end
	end,
}

FileNameBlock = utils.insert(
	FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName),
	unpack(FileFlags),
	{ provider = "%<" }
)

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	on_click = {
		callback = function()
			-- require("trouble").toggle({ mode = "document_diagnostics" })
			-- or
			vim.diagnostic.setqflist()
		end,
		name = "heirline_diagnostics",
	},

	static = require("config").icons.diagnostics,

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	{ provider = "![" },
	{
		provider = function(self)
			return self.errors > 0 and (self.Error .. self.errors .. " ")
		end,
		hl = { fg = "diag_error" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.Warn .. self.warnings .. " ")
		end,
		hl = { fg = "diag_warn" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.Info .. self.info .. " ")
		end,
		hl = { fg = "diag_info" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.Hint .. self.hints)
		end,
		hl = { fg = "diag_hint" },
	},
	{ provider = "]" },
}

local Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		---@diagnostic disable-next-line: undefined-field
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	on_click = {
		callback = function()
			util.float_term({ "lazygit" }, { cwd = util.get_root() })
		end,
		name = "heirline_git",
		update = false,
	},

	hl = { fg = "work_dir" },

	{
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { bold = true },
	},

	{
		condition = function(self)
			return self.has_changes
		end,
		provider = "(",
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count)
		end,
		hl = { fg = "git_add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count)
		end,
		hl = { fg = "git_del" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = "git_change" },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = ")",
	},
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	-- provider = " ◍ LSP ",
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " ◍ [" .. table.concat(names, ",") .. "]"
	end,
	hl = { fg = "green" },

	on_click = {
		callback = function()
			vim.defer_fn(function()
				require("lspconfig.ui.lspinfo")()
			end, 100)
		end,
		name = "heirline_LSP",
	},
}

local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %v = virtual column number (screen column)
	-- %P = percentage through file of displayed window
	provider = " %3p%% %2l(%02v)/%-3L",
}

local ScrollBar = {
	static = { sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } },
	provider = function(self)
		local curr_line = api.nvim_win_get_cursor(0)[1]
		local lines = api.nvim_buf_line_count(0)
		local i
		if lines > 0 then
			i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		else
			i = #self.sbar
		end
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = "blue", bg = "bright_bg" },
}

local TerminalName = {
	provider = function()
		local tname, _ = api.nvim_buf_get_name(0):gsub(".*:", "")
		return " " .. tname
	end,
	hl = { fg = "blue", bold = true },
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = api.nvim_buf_get_name(0)
		return fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = "blue" },
}

local Align = { provider = "%=" }
local Space = { provider = " " }

local DefaultStatusline = {
	LeftCap,
	VimMode,
	Space,
	Snippets,
	Space,
	WorkDir,
	Align,
	Diagnostics,
	Space,
	Git,
	LSPActive,
	Ruler,
	Space,
	ScrollBar,
}

local InactiveStatusline = {
	condition = conditions.is_not_active,

	Space,
	FileType,
	Space,
	FileName,
	Align,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,

	FileType,
	Space,
	HelpFileName,
	Align,
}

local TerminalStatusline = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,
	hl = { bg = "dark_red" },

	{ condition = conditions.is_active, LeftCap, VimMode, Space },
	FileType,
	Space,
	TerminalName,
	Align,
}

local StatusLine = {
	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLineNC"
		end
	end,

	fallthrough = false,

	SpecialStatusline,
	TerminalStatusline,
	InactiveStatusline,
	DefaultStatusline,
}

-- Tabline
local TablineBufnr = {
	provider = function(self)
		return tostring(self.bufnr) .. ". "
	end,
	hl = "Comment",
}

local TablineFileName = {
	provider = function(self)
		local filename = self.filename
		filename = filename == "" and "[No Name]" or fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible, italic = true }
	end,
}

local TablineFileFlags = {
	{
		condition = function(self)
			return api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = "[+]",
		hl = { fg = "green" },
	},
	{
		condition = function(self)
			return not api.nvim_buf_get_option(self.bufnr, "modifiable")
				or api.nvim_buf_get_option(self.bufnr, "readonly")
		end,
		provider = function(self)
			if api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
				return "  "
			else
				return ""
			end
		end,
		hl = { fg = "orange" },
	},
}

local TablineFileNameBlock = {
	init = function(self)
		self.filename = api.nvim_buf_get_name(self.bufnr)
	end,
	hl = function(self)
		if self.is_active then
			return "TabLineSel"
		-- elseif not api.nvim_buf_is_loaded(self.bufnr) then
		--   return { fg = "gray" }
		else
			return "TabLine"
		end
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then
				api.nvim_buf_delete(minwid, { force = false })
			else
				api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	TablineBufnr,
	FileIcon,
	TablineFileName,
	TablineFileFlags,
}

local TablineCloseButton = {
	condition = function(self)
		return not api.nvim_buf_get_option(self.bufnr, "modified")
	end,
	{ provider = " " },
	{ -- ✗    
		provider = "✗",
		hl = { fg = "gray" },
		on_click = {
			callback = function(_, minwid)
				api.nvim_buf_delete(minwid, { force = false })
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
}

local TablineBufferBlock = utils.surround({ "", "" }, function(self)
	if self.is_active then
		return utils.get_highlight("TabLineSel").bg
	else
		return utils.get_highlight("TabLine").bg
	end
end, { TablineFileNameBlock, TablineCloseButton })

local BufferLine = utils.make_buflist(
	TablineBufferBlock,
	{ provider = " ", hl = { fg = "gray" } },
	{ provider = " ", hl = { fg = "gray" } }
)

local Tabpage = {
	provider = function(self)
		return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
	end,
	hl = function(self)
		if not self.is_active then
			return "TabLine"
		else
			return "TabLineSel"
		end
	end,
}

local TabpageClose = { provider = " %999X %X", hl = "TabLine" }

local TabPages = {
	condition = function()
		return #api.nvim_list_tabpages() >= 2
	end,
	{ provider = "%=" },
	utils.make_tablist(Tabpage),
	TabpageClose,
}

local TabLineOffset = {
	condition = function(self)
		local win = api.nvim_tabpage_list_wins(0)[1]
		-- local bufnr = api.nvim_win_get_buf(win)
		self.winid = win

		-- if vim.bo[bufnr].filetype == "neo-tree" then
		--   self.title = "neo-tree"
		--   return true
		-- elseif vim.bo[bufnr].filetype == "aerial" then
		--   self.title = "aerial"
		--   return true
		-- end
	end,

	provider = function(self)
		local title = self.title
		local width = api.nvim_win_get_width(self.winid)
		local pad = math.ceil((width - #title) / 2)
		return string.rep(" ", pad) .. title .. string.rep(" ", pad)
	end,

	hl = function(self)
		if api.nvim_get_current_win() == self.winid then
			return "TablineSel"
		else
			return "Tabline"
		end
	end,
}

local TabLine = { TabLineOffset, BufferLine, TabPages }

-- local StatusColumn = {
-- 	static = {
-- 		click_args = function(self, minwid, clicks, button, mods)
-- 			local args = {
-- 				minwid = minwid,
-- 				clicks = clicks,
-- 				button = button,
-- 				mods = mods,
-- 				mousepos = fn.getmousepos(),
-- 			}
-- 			local sign = fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol)
-- 			if sign == " " then
-- 				sign = fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol - 1)
-- 			end
-- 			args.sign = self.signs[sign]
-- 			api.nvim_set_current_win(args.mousepos.winid)
-- 			api.nvim_win_set_cursor(0, { args.mousepos.line, 0 })
-- 			-- vim.pretty_print(args)
-- 			return args
-- 		end,
-- 		handlers = {
-- 			number = function(args)
-- 				if args.button == "m" then
-- 					local dap_avail, dap = pcall(require, "dap")
-- 					if dap_avail then
-- 						dap.toggle_breakpoint()
-- 					end
-- 				end
-- 			end,
-- 		},
-- 	},
-- 	init = function(self)
-- 		-- initialize sign lookup table
-- 		self.signs = {}
-- 		for _, sign in ipairs(fn.sign_getdefined()) do
-- 			if sign.text then
-- 				self.signs[sign.text:gsub("%s", "")] = sign
-- 			end
-- 		end
--
-- 		-- setup sign handlers
-- 		if not self.handlers then
-- 			self.handlers = {}
-- 		end
-- 		-- gitsigns handlers
-- 		local gitsigns = function(_)
-- 			local gitsigns_avail, gitsigns = pcall(require, "gitsigns")
-- 			if gitsigns_avail then
-- 				vim.schedule(gitsigns.preview_hunk)
-- 			end
-- 		end
-- 		for _, sign in ipairs({ "Topdelete", "Untracked", "Add", "Changedelete", "Delete" }) do
-- 			local name = "GitSigns" .. sign
-- 			if not self.handlers[name] then
-- 				self.handlers[name] = gitsigns
-- 			end
-- 		end
-- 		-- diagnostic handlers
-- 		local diagnostics = function(args)
-- 			if args.button == "l" then
-- 				vim.schedule(vim.diagnostic.open_float)
-- 			elseif args.button == "m" then
-- 				vim.schedule(vim.lsp.buf.code_action)
-- 			end
-- 		end
-- 		for _, sign in ipairs({ "Error", "Hint", "Info", "Warn" }) do
-- 			local name = "DiagnosticSign" .. sign
-- 			if not self.handlers[name] then
-- 				self.handlers[name] = diagnostics
-- 			end
-- 		end
-- 		-- DAP handlers
-- 		local dap_breakpoint = function(_)
-- 			local dap_avail, dap = pcall(require, "dap")
-- 			if dap_avail then
-- 				vim.schedule(dap.toggle_breakpoint)
-- 			end
-- 		end
-- 		for _, sign in ipairs({ "", "Rejected", "Condition" }) do
-- 			local name = "DapBreakpoint" .. sign
-- 			if not self.handlers[name] then
-- 				self.handlers[name] = dap_breakpoint
-- 			end
-- 		end
-- 	end,
-- 	condition = function()
-- 		return vim.opt.number:get() or vim.opt.relativenumber:get()
-- 	end,
-- 	{
-- 		provider = function()
-- 			local str = "%="
-- 			local num, relnum = vim.opt.number:get(), vim.opt.relativenumber:get()
-- 			if num and not relnum then
-- 				str = str .. "%l"
-- 			elseif relnum and not num then
-- 				str = str .. "%r"
-- 			else
-- 				str = str .. "%{v:relnum?v:relnum:v:lnum}"
-- 			end
-- 			return str
-- 		end,
-- 		on_click = {
-- 			name = "line_click",
-- 			callback = function(self, ...)
-- 				if self.handlers.number then
-- 					self.handlers.number(self.click_args(self, ...))
-- 				end
-- 			end,
-- 		},
-- 	},
-- 	{ provider = " " },
-- 	{
-- 		provider = "%s",
-- 		on_click = {
-- 			name = "sign_click",
-- 			callback = function(self, ...)
-- 				local args = self.click_args(self, ...)
-- 				if args.sign and args.sign.name and self.handlers[args.sign.name] then
-- 					self.handlers[args.sign.name](args)
-- 				end
-- 			end,
-- 		},
-- 	},
-- 	{ provider = "%C" },
-- }

require("heirline").setup({
	statusline = StatusLine,
	-- winbar = WinBar,
	tabline = TabLine,
	-- statuscolumn = StatusColumn,
})

vim.o.showtabline = 2

api.nvim_create_augroup("Heirline", {})
api.nvim_create_autocmd({ "FileType" }, {
	command = "if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif",
	group = "Heirline",
})