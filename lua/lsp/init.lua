require('packer').loader('cmp-nvim-lsp')

-- lsp info
vim.keymap.set('n', '<leader>li', function()
	require('lspconfig.ui.lspinfo')()
end, { desc = 'Lsp Info' })

-- Diagnostic
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Float diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostics' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Loclist diagnostics' })

local on_attach = function(client, bufnr)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Declaration' })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Docs Hover' })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature' })
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {
		buffer = bufnr,
		desc = 'Add Workspace Folder',
	})
	vim.keymap.set(
		'n',
		'<leader>wr',
		vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = 'Remove Workspace Folder' }
	)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = 'List Workspace Folders' })
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })

	local tb = require('telescope.builtin')
	vim.keymap.set('n', 'gd', function()
		tb.lsp_definitions()
	end, { buffer = bufnr, desc = 'Definitions' })
	vim.keymap.set('n', 'gr', function()
		tb.lsp_references()
	end, { buffer = bufnr, desc = 'References' })
	vim.keymap.set('n', 'gi', function()
		tb.lsp_implementations()
	end, { buffer = bufnr, desc = 'Implementations' })
	vim.keymap.set('n', '<leader>so', function()
		tb.lsp_document_symbols()
	end, { buffer = bufnr, desc = 'Document Symbols' })
	vim.keymap.set('n', '<leader>D', function()
		tb.lsp_type_definitions()
	end, { buffer = bufnr, desc = 'Type Definitions' })

	local augroup = vim.api.nvim_create_augroup
	local autocmd = vim.api.nvim_create_autocmd

	if client.resolved_capabilities.document_highlight then
		augroup { name = 'lsp_document_highlight' }
		autocmd {
			group = 'lsp_document_highlight',
			event = 'CursorHold',
			pattern = '<buffer>',
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		}
		autocmd {
			group = 'lsp_document_highlight',
			event = 'CursorMoved',
			pattern = '<buffer>',
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		}
	end

	if client.resolved_capabilities.code_action then
		vim.keymap.set('n', '<leader>ca', function()
			tb.lsp_code_actions()
		end, { buffer = bufnr, desc = 'Code Actions' })
		vim.keymap.set('v', '<leader>ca', function()
			tb.lsp_range_code_actions()
		end, { buffer = bufnr, desc = 'Range Code Actions' })

		augroup { name = 'lsp_code_action' }
		autocmd {
			group = 'lsp_code_action',
			event = { 'CursorHold', 'CursorHoldI' },
			pattern = '<buffer>',
			callback = function()
				require('nvim-lightbulb').update_lightbulb()
			end,
		}
	end

	if client.resolved_capabilities.document_formatting then
		vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, { buffer = bufnr, desc = 'Formmating' })
	end
	if client.resolved_capabilities.document_range_formatting then
		vim.keymap.set('v', '<leader>lf', vim.lsp.buf.range_formatting, { buffer = bufnr, desc = 'Range Formmating' })
	end

	require('aerial').on_attach(client, bufnr)
	-- vim.keymap.set('n', '<M-o>', '<Cmd>AerialToggle<CR>', { buffer = bufnr, desc = 'Aerial code outline' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, server in ipairs { 'pyright', 'sumneko_lua', 'texlab' } do
	require('lsp.' .. server).setup(on_attach, capabilities)
end
