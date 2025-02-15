return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
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
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
			-- vim.cmd.colorscheme("carbonfox")
			-- vim.cmd.colorscheme("dawnfox")
			-- vim.cmd.colorscheme("dayfox")
			vim.cmd.colorscheme("duskfox")
			-- vim.cmd.colorscheme("nightfox")
			-- vim.cmd.colorscheme("nordfox")
			-- vim.cmd.colorscheme("terafox")
		end,
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			require("tokyonight").setup({
				-- transparent = true,
				transparent = false,
				style = "moon",
				-- style = "storm",
				-- style = "night",
				-- style = "day",
			})
			vim.cmd.colorscheme "tokyonight"
		end,
	},

	{
		"Mofiqul/dracula.nvim",
		priortiy = 1000,
		enabled = false,
		config = function()
			require("dracula").setup({
				transparent_bg = true,
				-- transparent_bg = false,
			})
			vim.cmd.colorscheme("dracula")
			-- vim.cmd.colorscheme("dracula-soft")
		end,
	},
}
