-- Modified from https://github.com/eddyekofo94/gruvbox-flat.nvim
vim.g.colors_name = 'gruvbox'

local util = require 'themes.util'
local c = {}

c = {
	bg            = '#1D2021',
	bg2           = '#17191A',
	bg_visual     = '#3C3836',
	border        = '#3C3836',
	line_cursor   = '#45403D',
	prompt_border = '#45403D',
	bg_highlight  = '#3C3836',
	fg            = '#D4BE98',
	fg_light      = '#DDC7A1',
	fg_dark       = '#D4BE98',
	tree_normal   = '#AA9987',
	comment       = '#6A635D',
	fg_gutter     = '#5A524C',
	dark5         = '#5A524C',
	blue          = '#7DAEA3',
	aqua          = '#89B482',
	purple        = '#D3869B',
	orange        = '#E78A4E',
	yellow        = '#D8A657',
	yellow2       = '#B47109',
	bg_yellow     = '#A96B2C',
	green         = '#A9B665',
	red           = '#EA6962',
	red1          = '#C14A4A',
	black         = '#1D2021',
	git           = {
		delete = '#C14A4A',
		add    = '#6F8352',
		change = '#B47109',
		bg_red = '#AE5858',
	},
	gitSigns      = {
		delete = '#AE5858',
		add    = '#6F8352',
		change = '#A96B2C',
	}
}

c.line_cursor = util.lighten(c.bg, 0.97)

util.bg = c.bg

c.diff = {
	add    = util.darken(c.git.add, 0.15),
	delete = util.darken(c.git.delete, 0.15),
	change = util.darken(c.git.change, 0.15),
	text   = c.fg_gutter,
}

c.gitSigns = {
	add    = util.brighten(c.gitSigns.add, 0.2),
	change = util.brighten(c.gitSigns.change, 0.2),
	delete = util.brighten(c.gitSigns.delete, 0.2),
}

c.git.ignore       = c.fg_gutter
c.black            = util.darken(c.bg, 0.8, '#000000')
c.border_highlight = c.border

-- Popups and statusline always get a dark background
c.bg_popup      = c.bg2
c.bg_statusline = c.bg2

c.bg_sidebar = c.bg
c.bg_float   = c.bg

c.bg_search  = c.bg_highlight
c.fg_search  = c.fg
c.fg_sidebar = c.fg_dark

c.error   = c.red1
c.warning = c.yellow
c.info    = c.blue
c.hint    = c.aqua

---------- BASICS ----------
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = c.bg_visual })
vim.api.nvim_set_hl(0, 'Comment', { fg = c.comment, italic = true })
vim.api.nvim_set_hl(0, 'Conceal', { fg = c.fg_gutter })
vim.api.nvim_set_hl(0, 'Cursor', { fg = c.bg, bg = c.fg })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = c.line_cursor })
-- vim.api.nvim_set_hl(0, 'CursorIM', { fg = c.bg, bg = c.fg })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = c.line_cursor })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = c.purple })
vim.api.nvim_set_hl(0, 'Directory', { fg = c.blue })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = c.bg })
vim.api.nvim_set_hl(0, 'ErrorMsg', { fg = c.error })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = c.border_highlight })
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = c.fg_gutter, bg = c.bg })
vim.api.nvim_set_hl(0, 'Folded', { fg = c.blue, bg = c.fg_gutter })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = c.black, bg = c.orange })
vim.api.nvim_set_hl(0, 'lCursor', { fg = c.bg, bg = c.fg })
vim.api.nvim_set_hl(0, 'LineNr', { fg = c.fg_gutter })
vim.api.nvim_set_hl(0, 'MatchParen', { fg = util.lighten(c.purple, 0.95), bold = true })
vim.api.nvim_set_hl(0, 'ModeMsg', { fg = c.fg_dark, bold = true })
vim.api.nvim_set_hl(0, 'MoreMsg', { fg = c.blue })
vim.api.nvim_set_hl(0, 'MsgArea', { fg = c.fg_dark })
-- vim.api.nvim_set_hl(0, 'MsgSeparator', {})
vim.api.nvim_set_hl(0, 'NonText', { fg = c.bg_highlight })
vim.api.nvim_set_hl(0, 'Normal', { fg = c.fg, bg = c.bg })
vim.api.nvim_set_hl(0, 'NormalFloat', { fg = c.fg, bg = c.bg_float })
vim.api.nvim_set_hl(0, 'NormalNC', { fg = c.fg, bg = c.bg })
-- vim.api.nvim_set_hl(0, 'NormalSB', { fg = c.fg_sidebar, bg = c.bg_sidebar })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = c.fg, bg = c.bg_popup })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = util.lighten(c.bg_popup, 0.95) })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = util.darken(c.fg_gutter, 0.8) })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = c.fg_gutter })
vim.api.nvim_set_hl(0, 'Question', { fg = c.blue })
vim.api.nvim_set_hl(0, 'QuickFixLine', { bg = c.bg_visual, bold = true })
vim.api.nvim_set_hl(0, 'Search', { fg = c.fg_search, bg = c.bg_search })
vim.api.nvim_set_hl(0, 'SignColumn', { fg = c.fg_gutter, bg = c.bg })
-- vim.api.nvim_set_hl(0, 'SignColumnSB', { fg = c.fg_gutter, bg = c.bg_sidebar })
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = c.fg_gutter })
vim.api.nvim_set_hl(0, 'StatusLine', { fg = c.fg_sidebar, bg = c.bg_highlight })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = c.fg_gutter, bg = c.bg_statusline })
vim.api.nvim_set_hl(0, 'Substitute', { fg = c.black, bg = c.red })
vim.api.nvim_set_hl(0, 'TabLine', { fg = c.fg_gutter, bg = c.bg_statusline })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = c.black })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = c.black, bg = c.blue })
-- vim.api.nvim_set_hl(0, 'TermCursor', {})
-- vim.api.nvim_set_hl(0, 'TermCursorNC', {})
vim.api.nvim_set_hl(0, 'Title', { fg = c.blue, bold = true })
-- vim.api.nvim_set_hl(0, 'VertSplit', { fg = c.bg_highlight })
vim.api.nvim_set_hl(0, 'Visual', { bg = c.bg_visual })
vim.api.nvim_set_hl(0, 'VisualNOS', { bg = c.bg_visual })
vim.api.nvim_set_hl(0, 'WarningMsg', { fg = c.warning })
vim.api.nvim_set_hl(0, 'Whitespace', { fg = c.fg_gutter })
vim.api.nvim_set_hl(0, 'WildMenu', { bg = c.bg_visual })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = c.bg_highlight })

---------- DIFF ----------
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = c.diff.add })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = c.diff.change })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = c.diff.delete })
vim.api.nvim_set_hl(0, 'DiffText', { bg = c.diff.text })

---------- SPELL ----------
vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = c.error })
vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = c.warning })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = c.info })
vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true, sp = c.hint })

---------- SYNTAX ----------
-- vim.api.nvim_set_hl(0, 'Boolean', {})
vim.api.nvim_set_hl(0, 'Character', { fg = c.green })
-- vim.api.nvim_set_hl(0, 'Conditional', {})
vim.api.nvim_set_hl(0, 'Constant', { fg = c.orange })
-- vim.api.nvim_set_hl(0, 'Debug', {})
-- vim.api.nvim_set_hl(0, 'Define', {})
-- vim.api.nvim_set_hl(0, 'Delimiter', {})
vim.api.nvim_set_hl(0, 'Error', { fg = c.error })
-- vim.api.nvim_set_hl(0, 'Exception', {})
-- vim.api.nvim_set_hl(0, 'Float', {})
vim.api.nvim_set_hl(0, 'Function', { fg = c.blue })
vim.api.nvim_set_hl(0, 'Identifier', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'Ignore', {})
-- vim.api.nvim_set_hl(0, 'Include', {})
vim.api.nvim_set_hl(0, 'Keyword', { fg = c.aqua, italic = true })
-- vim.api.nvim_set_hl(0, 'Label', {})
-- vim.api.nvim_set_hl(0, 'Macro', {})
-- vim.api.nvim_set_hl(0, 'Number', {})
vim.api.nvim_set_hl(0, 'Operator', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'PreCondit', {})
vim.api.nvim_set_hl(0, 'PreProc', { fg = c.aqua })
-- vim.api.nvim_set_hl(0, 'Repeat', {})
vim.api.nvim_set_hl(0, 'Special', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'SpecialChar', {})
-- vim.api.nvim_set_hl(0, 'SpecialComment', {})
vim.api.nvim_set_hl(0, 'Statement', { fg = c.purple })
-- vim.api.nvim_set_hl(0, 'StorageClass', {})
vim.api.nvim_set_hl(0, 'String', { fg = c.green })
-- vim.api.nvim_set_hl(0, 'Structure', {})
-- vim.api.nvim_set_hl(0, 'Tag', {})
vim.api.nvim_set_hl(0, 'Todo', { fg = c.bg, bg = c.yellow })
vim.api.nvim_set_hl(0, 'Type', { fg = c.yellow })
-- vim.api.nvim_set_hl(0, 'Typedef', {})
vim.api.nvim_set_hl(0, 'Underlined', { underline = true })

---------- MISC ----------
-- vim.api.nvim_set_hl(0, 'debugPC', { bg = c.bg_sidebar })
-- vim.api.nvim_set_hl(0, 'debugBreakpoint', { fg = c.info, bg = util.darken(c.info, 0.1) })

vim.api.nvim_set_hl(0, 'healthError', { fg = c.error })
vim.api.nvim_set_hl(0, 'healthSuccess', { fg = c.green })
vim.api.nvim_set_hl(0, 'healthWarning', { fg = c.warning })

vim.api.nvim_set_hl(0, 'qfLineNr', { fg = c.dark5 })
vim.api.nvim_set_hl(0, 'qfFileName', { fg = c.blue })

---------- DIAGNOSTIC ----------
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = c.error })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = c.warning })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = c.info })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = c.hint })

vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { bg = util.darken(c.error, 0.1), fg = c.error })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg = util.darken(c.warning, 0.1), fg = c.warning })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg = util.darken(c.info, 0.1), fg = c.info })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg = util.darken(c.hint, 0.1), fg = c.hint })

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = c.error })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = c.warning })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = c.info })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = c.hint })

---------- NVIM LSP ----------
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = c.bg_visual })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = c.bg_visual })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = c.bg_visual })

---------- AERIAL ----------
vim.api.nvim_set_hl(0, 'AerialLine', { link = 'CursorLine' })
vim.api.nvim_set_hl(0, 'AerialGuide', { link = 'LineNr' })
vim.api.nvim_set_hl(0, 'AerialFileIcon', { fg = c.green })
vim.api.nvim_set_hl(0, 'AerialModuleIcon', { fg = c.purple })
vim.api.nvim_set_hl(0, 'AerialNamespaceIcon', { fg = c.purple })
vim.api.nvim_set_hl(0, 'AerialPackageIcon', { fg = c.purple })
vim.api.nvim_set_hl(0, 'AerialClassIcon', { fg = c.red })
vim.api.nvim_set_hl(0, 'AerialMethodIcon', { fg = c.green })
vim.api.nvim_set_hl(0, 'AerialPropertyIcon', { fg = c.blue })
vim.api.nvim_set_hl(0, 'AerialFieldIcon', { fg = c.green })
vim.api.nvim_set_hl(0, 'AerialConstructorIcon', { fg = c.green })
vim.api.nvim_set_hl(0, 'AerialEnumIcon', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'AerialInterfaceIcon', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'AerialFunctionIcon', { fg = c.green })
vim.api.nvim_set_hl(0, 'AerialVariableIcon', { fg = c.blue })
vim.api.nvim_set_hl(0, 'AerialConstantIcon', { fg = c.blue })
vim.api.nvim_set_hl(0, 'AerialStringIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialNumberIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialBooleanIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialArrayIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialObjectIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialKeyIcon', { fg = c.red })
vim.api.nvim_set_hl(0, 'AerialNullIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialEnumMemberIcon', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'AerialStructIcon', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'AerialEventIcon', { fg = c.orange })
vim.api.nvim_set_hl(0, 'AerialOperatorIcon', { fg = c.orange })
vim.api.nvim_set_hl(0, 'AerialTypeParameterIcon', { fg = c.yellow })

---------- BUFFERLINE ----------
-- vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', { fg = c.git.change })
-- vim.api.nvim_set_hl(0, 'BufferLineFill', { bg = c.black })

---------- CMP ----------
vim.api.nvim_set_hl(0, 'CmpDocumentation', { fg = c.fg, bg = c.bg_float })
vim.api.nvim_set_hl(0, 'CmpDocumentationBorder', { fg = c.border, bg = c.bg_float })

vim.api.nvim_set_hl(0, 'CmpItemAbbr', { fg = c.fg })
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = c.fg_gutter, strikethrough = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = c.blue })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = c.blue })
vim.api.nvim_set_hl(0, 'CmpItemKindDefault', { fg = c.fg_dark })
vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = c.comment })

vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = c.orange })
vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = c.purple })
vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = c.blue })
vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = c.orange })
vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = c.green })
vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = c.orange })
vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = c.green })
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = c.blue })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = c.orange })
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = c.blue })
vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = c.green })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = c.green })
vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = c.purple })
vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = c.red })
vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = c.orange })
vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = c.green })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = c.orange })
vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = c.purple })
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = c.purple })

---------- GITSIGNS ----------
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = c.gitSigns.add })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = c.gitSigns.change })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = c.gitSigns.delete })

---------- NVIM-TREE ----------
-- vim.api.nvim_set_hl(0, 'NvimTreeNormal', { fg = c.tree_normal, bg = c.bg_sidebar })
-- vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = c.comment })
-- vim.api.nvim_set_hl(0, 'NvimTreeRootFolder', { fg = c.fg_light, bold = true })
-- vim.api.nvim_set_hl(0, 'NvimTreeSymlink', { fg = c.blue })
-- vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = c.tree_normal })
-- vim.api.nvim_set_hl(0, 'NvimTreeEmptyFolderName', { fg = c.comment })
-- vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = c.purple })
-- vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = c.purple })
-- vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = c.yellow2 })
-- vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { fg = c.git.add })
-- vim.api.nvim_set_hl(0, 'NvimTreeGitDeleted', { fg = c.git.delete })
-- vim.api.nvim_set_hl(0, 'NvimTreeSpecialFile', { fg = c.yellow, underline = true })
-- vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = c.fg_gutter })
-- vim.api.nvim_set_hl(0, 'NvimTreeImageFile', { fg = c.fg_sidebar })

---------- RAINBOW ----------
vim.api.nvim_set_hl(0, 'rainbowcol1', { fg = c.red })
vim.api.nvim_set_hl(0, 'rainbowcol2', { fg = c.orange })
vim.api.nvim_set_hl(0, 'rainbowcol3', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'rainbowcol4', { fg = c.green })
vim.api.nvim_set_hl(0, 'rainbowcol5', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'rainbowcol6', { fg = c.blue })
vim.api.nvim_set_hl(0, 'rainbowcol7', { fg = c.purple })

---------- TELESCOPE ----------
vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = util.darken(c.fg, 0.75) })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = c.fg_light })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = util.darken(c.fg, 0.75) })
vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = c.purple })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = c.purple, bg = c.bg_highlight })
vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = c.blue })

---------- TREESITTER ----------
-- vim.api.nvim_set_hl(0, 'TSAnnotation', {})
-- vim.api.nvim_set_hl(0, 'TSAttribute', {})
-- vim.api.nvim_set_hl(0, 'TSBoolean', {})
-- vim.api.nvim_set_hl(0, 'TSCharacter', {})
-- vim.api.nvim_set_hl(0, 'TSComment', {})
-- vim.api.nvim_set_hl(0, 'TSConditional', {})
vim.api.nvim_set_hl(0, 'TSConstant', { fg = c.yellow })
-- vim.api.nvim_set_hl(0, 'TSConstBuiltin', {})
-- vim.api.nvim_set_hl(0, 'TSConstMacro', {})
vim.api.nvim_set_hl(0, 'TSConstructor', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'TSDanger', { fg = c.bg, bg = c.error })
-- vim.api.nvim_set_hl(0, 'TSEmphasis', {})
-- vim.api.nvim_set_hl(0, 'TSEnvironment', { fg = c.yellow }) --
-- vim.api.nvim_set_hl(0, 'TSEnvironmentName', { fg = c.purple }) --
-- vim.api.nvim_set_hl(0, 'TSError', {})
-- vim.api.nvim_set_hl(0, 'TSException', {})
vim.api.nvim_set_hl(0, 'TSField', { fg = c.aqua })
-- vim.api.nvim_set_hl(0, 'TSFloat', {})
-- vim.api.nvim_set_hl(0, 'TSFuncBuiltin', {})
-- vim.api.nvim_set_hl(0, 'TSFuncMacro', {})
-- vim.api.nvim_set_hl(0, 'TSFunction', {})
vim.api.nvim_set_hl(0, 'TSInclude', { fg = c.blue })
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = c.purple, italic = true })
vim.api.nvim_set_hl(0, 'TSKeywordFunction', { fg = c.purple })
vim.api.nvim_set_hl(0, 'TSLabel', { fg = c.blue })
-- vim.api.nvim_set_hl(0, 'TSLiteral', {})
vim.api.nvim_set_hl(0, 'TSMath', { fg = c.green }) --
-- vim.api.nvim_set_hl(0, 'TSMethod', {})
vim.api.nvim_set_hl(0, 'TSNamespace', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'TSNone', {})
vim.api.nvim_set_hl(0, 'TSNote', { fg = c.bg, bg = c.info })
-- vim.api.nvim_set_hl(0, 'TSNumber', {})
vim.api.nvim_set_hl(0, 'TSOperator', { fg = util.darken(c.orange, 0.85) })
vim.api.nvim_set_hl(0, 'TSParameter', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'TSParameterReference', {})
vim.api.nvim_set_hl(0, 'TSProperty', { fg = c.red })
vim.api.nvim_set_hl(0, 'TSPunctBracket', { fg = util.darken(c.orange, 0.85) })
vim.api.nvim_set_hl(0, 'TSPunctDelimiter', { fg = c.red })
vim.api.nvim_set_hl(0, 'TSPunctSpecial', { fg = util.darken(c.orange, 0.85) })
-- vim.api.nvim_set_hl(0, 'TSRepeat', {})
-- vim.api.nvim_set_hl(0, 'TSStrike', {})
-- vim.api.nvim_set_hl(0, 'TSString', {})
vim.api.nvim_set_hl(0, 'TSStringEscape', { fg = c.red })
vim.api.nvim_set_hl(0, 'TSStringRegex', { fg = c.orange })
-- vim.api.nvim_set_hl(0, 'TSSymbol', {})
vim.api.nvim_set_hl(0, 'TSTag', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'TSTagDelimiter', {})
-- vim.api.nvim_set_hl(0, 'TSText', {})
vim.api.nvim_set_hl(0, 'TSTextReference', { fg = c.red })
-- vim.api.nvim_set_hl(0, 'TSTitle', {})
-- vim.api.nvim_set_hl(0, 'TSType', {})
-- vim.api.nvim_set_hl(0, 'TSTypeBuiltin', {})
-- vim.api.nvim_set_hl(0, 'TSUnderline', {})
-- vim.api.nvim_set_hl(0, 'TSURI', {})
vim.api.nvim_set_hl(0, 'TSVariable', {})
vim.api.nvim_set_hl(0, 'TSVariableBuiltin', { fg = c.aqua })
vim.api.nvim_set_hl(0, 'TSWarning', { fg = c.bg, bg = c.warning })

---------- LANGUAGES ----------

---------- LATEX ----------
-- vim.api.nvim_set_hl(0, 'latexTSEnvironment', { fg = c.blue })
-- vim.api.nvim_set_hl(0, 'latexTSEnvironmentName', { fg = c.yellow })
-- vim.api.nvim_set_hl(0, 'latexTSParameter', { fg = c.orange })

---------- LUA ----------
-- vim.api.nvim_set_hl(0, 'luaTSProperty', { fg = c.red })

-------- TEX ----------
vim.api.nvim_set_hl(0, 'texCmd', { fg = c.red, italic = true })
vim.api.nvim_set_hl(0, 'texCmdClass', { fg = c.purple })
vim.api.nvim_set_hl(0, 'texCmdTitle', { fg = c.purple })
vim.api.nvim_set_hl(0, 'texCmdAuthor', { fg = c.purple })
vim.api.nvim_set_hl(0, 'texFileArg', { fg = c.blue })
vim.api.nvim_set_hl(0, 'texCmdDef', { fg = c.purple })
vim.api.nvim_set_hl(0, 'texDefArgName', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'texPartArgTitle', { fg = c.yellow })
vim.api.nvim_set_hl(0, 'texCmdEnv', { fg = c.purple })
vim.api.nvim_set_hl(0, 'texCmdPart', { fg = c.purple })
vim.api.nvim_set_hl(0, 'texEnvArgName', { fg = c.green })
vim.api.nvim_set_hl(0, 'texMathEnvArgName', { fg = c.green })

---------- TERMINAL COLORS ----------
local dark = c.comment
-- dark
vim.g.terminal_color_0 = dark
vim.g.terminal_color_8 = dark

-- light
vim.g.terminal_color_7  = c.fg_dark
vim.g.terminal_color_15 = c.fg

-- colors
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_9 = c.red

vim.g.terminal_color_2  = c.green
vim.g.terminal_color_10 = c.green

vim.g.terminal_color_3  = c.yellow
vim.g.terminal_color_11 = c.yellow

vim.g.terminal_color_4  = c.blue
vim.g.terminal_color_12 = c.blue

vim.g.terminal_color_5  = c.purple
vim.g.terminal_color_13 = c.purple

vim.g.terminal_color_6  = c.aqua
vim.g.terminal_color_14 = c.aqua
