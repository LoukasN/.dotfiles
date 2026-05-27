vim.g.netrw_banner = 0
-- Enables numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Disables swap
vim.opt.swapfile = false

-- Disables backup
vim.opt.backup = false

-- Sets undo folder
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

-- Disables highlighting search and enables incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Colors
vim.opt.termguicolors = true

-- Borders
vim.opt.winborder = "rounded"

-- Visible lines before scrolling
vim.opt.scrolloff = 12

-- Sidebar 1
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"

-- faster update time
vim.opt.updatetime = 50

-- line break
vim.opt.textwidth = 80

-- New window split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tab has size of 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.expandtab = true

-- highlight cursor line
vim.cmd("set cursorline")

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Set to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- True colors
vim.opt.termguicolors = true

-- Better highlighting when copying text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
