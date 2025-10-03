-- Custom mappings
require("config.keymaps")
-- Lazy package manager
require("config.lazy")

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

-- Colors
vim.opt.termguicolors = true

-- Borders
vim.opt.winborder = "rounded"

-- Visible lines before scrolling
vim.opt.scrolloff = 12

-- Sidebar 1
vim.opt.signcolumn = "yes:1"

-- faster update time
vim.opt.updatetime = 50

-- Tab has size of 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.expandtab = true

-- highlight cursor line
vim.cmd("set cursorline")

-- Use system clipboard
-- vim.o.clipboard = "unnamedplus"

-- Set to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- True colors
vim.o.termguicolors = true

-- Better highlighting when copying text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Spellchecking
vim.opt.spelllang = "en_us,el"
vim.opt.spell = true

-- Vim movement in Greek language
vim.o.langmap =
	"ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"
