local api, fn = vim.api, vim.fn
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd
local lsp = vim.lsp

local on_attach = function(client, bufnr)
	vim.keymap.set('n', 'K', lsp.buf.hover, { buffer = bufnr, desc = 'Docs Hover' })
	vim.keymap.set('n', '<C-k>', lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature' })
	vim.keymap.set('n', '<leader>rn', lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
	vim.keymap.set('n', 'gd', lsp.buf.definition, { buffer = bufnr, desc = 'Go to Definition' })
	vim.keymap.set(
		'n',
		'gr',
		require('telescope.builtin').lsp_references,
		{ buffer = bufnr, desc = 'Telescope References' }
	)

	local caps = client.server_capabilities

	if caps.documentHighlightProvider then
		augroup('lsp_document_highlight', { clear = false })
		api.nvim_clear_autocmds({
			buffer = bufnr,
			group = 'lsp_document_highlight',
		})
		autocmd('CursorHold', {
			callback = lsp.buf.document_highlight,
			buffer   = bufnr,
			group    = 'lsp_document_highlight',
		})
		autocmd('CursorMoved', {
			callback = lsp.buf.clear_references,
			buffer   = bufnr,
			group    = 'lsp_document_highlight',
		})
	end

	-- if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
	-- 	local augroup = augroup('SemanticTokens', {})
	-- 	autocmd('TextChanged', {
	-- 		group = augroup,
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			lsp.buf.semantic_tokens_full()
	-- 		end,
	-- 	})
	-- 	-- fire it first time on load as well
	-- 	lsp.buf.semantic_tokens_full()
	-- end

	if caps.codeActionProvider then
		vim.keymap.set(
			{ 'n', 'x' },
			'<leader>ca',
			function()
				require('lspsaga.codeaction'):code_action()
			end,
			{ buffer = bufnr, desc = '(Range) Code Actions' }
		)
	end

	if caps.documentFormattingProvider then
		vim.keymap.set(
			'n',
			'<leader>lf',
			function()
				lsp.buf.format({ bufnr = bufnr, async = true })
			end,
			{ buffer = bufnr, desc = 'Formmating' }
		)
	end
	if caps.documentRangeFormattingProvider then
		vim.keymap.set(
			'x',
			'<leader>lf',
			function()
				lsp.buf.format({ bufnr = bufnr, async = true })
			end,
			{ buffer = bufnr, desc = 'Range Formmating' }
		)
	end

	-- if caps.codeLensProvider then
	-- 	augroup('lsp_codelens', { clear = true })
	-- 	autocmd('BufEnter', {
	-- 		callback = require('lsp.codelens').refresh,
	-- 		buffer   = bufnr,
	-- 		group    = 'lsp_codelens',
	-- 		once     = true,
	-- 	})
	-- 	autocmd({ 'BufWritePost', 'CursorHold' }, {
	-- 		callback = require('lsp.codelens').refresh,
	-- 		buffer   = bufnr,
	-- 		group    = 'lsp_codelens',
	-- 	})
	-- end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = require('lspconfig')

require('neodev').setup()

require('mason').setup()
require('mason-lspconfig').setup()

local binary_path = fn.stdpath('data') .. '/site/pack/packer/start/nvim-texlabconfig/nvim-texlabconfig'
local cache_root = fn.stdpath('cache')

local executable = '/Applications/sioyek.app/Contents/MacOS/sioyek'
local args = {
	'--inverse-search',
	binary_path .. ' -file %1 -line %2 -cache_root ' .. cache_root,
	'--reuse-instance',
	'--forward-search-file',
	'%f',
	'--forward-search-line',
	'%l',
	'%p'
}
-- local executable = '/Applications/Skim.app/Contents/SharedSupport/displayline',
-- local args = { '%l', '%p', '%f' },

require('mason-lspconfig').setup_handlers {
	function(server_name)
		nvim_lsp[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end,
	['sumneko_lua'] = function()
		nvim_lsp.sumneko_lua.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end,
	['texlab'] = function()
		nvim_lsp.texlab.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				texlab = {
					build = {
						args = {
							'-xelatex',
							-- '-verbose',
							'-synctex=1',
							'-interaction=nonstopmode',
							'%f',
						},
						-- forwardSearchAfter = true,
						-- onSave = false,
					},
					forwardSearch = {
						executable = executable,
						args = args
					},
				},
			},
		}
	end
}

-- config sourcekit alone
nvim_lsp.sourcekit.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
