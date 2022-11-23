local o = vim.opt

-- global
vim.o.clipboard = 'unnamedplus'
vim.o.laststatus = 3
vim.o.pumheight = 10
vim.o.scrolloff = 6
vim.o.showbreak = '> '
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.updatetime = 200

-- opt
o.diffopt:append('linematch:60')
o.shortmess:append('c')
o.whichwrap:append('[,]')

-- Completion
o.completeopt = 'menu,menuone,noselect'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tabs
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- local to buffer
vim.bo.smartindent = true
vim.bo.spelllang = 'en_gb'
vim.bo.swapfile = false
vim.bo.undofile = true

-- local to window
vim.wo.breakindent = true
vim.wo.cursorline = true
vim.wo.linebreak = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

-- Theme
vim.cmd.colorscheme('vscode')
