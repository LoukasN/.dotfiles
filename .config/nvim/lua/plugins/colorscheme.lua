return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = true,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				transparent_background = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = true,
				},
			})
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false,
				},
			})
			-- vim.cmd.colorscheme("carbonfox")
			-- vim.cmd.colorscheme("dawnfox")
			-- vim.cmd.colorscheme("dayfox")
			-- vim.cmd.colorscheme("duskfox")
			-- vim.cmd.colorscheme("nightfox")
			-- vim.cmd.colorscheme("nordfox")
			-- vim.cmd.colorscheme("terafox")
		end,
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("tokyonight").setup({
				transparent = false,
				-- style = "moon",
				style = "storm",
				-- style = "night",
				-- style = "day",
			})
			-- vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("kanagawa").setup({
				transparent = false,
			})
			-- vim.cmd.colorscheme("kanagawa")
			-- vim.cmd.colorscheme("kanagawa-wave")
			vim.cmd.colorscheme("kanagawa-dragon")
			-- vim.cmd.colorscheme("kanagawa-lotus")
		end,
	},
}
