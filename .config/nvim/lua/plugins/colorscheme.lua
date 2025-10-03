return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = true,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
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
			vim.cmd.colorscheme("duskfox")
			-- vim.cmd.colorscheme("nightfox")
			-- vim.cmd.colorscheme("nordfox") 
            -- vim.cmd.colorscheme("terafox")
		end,
	},
}
