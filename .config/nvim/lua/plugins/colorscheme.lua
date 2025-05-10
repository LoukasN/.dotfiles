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
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					}
				end,
				overrides = function(colors)
					local theme = colors.theme
					return {
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
					}
				end,
			})
			-- vim.cmd.colorscheme("kanagawa")
			-- vim.cmd.colorscheme("kanagawa-wave")
			vim.cmd.colorscheme("kanagawa-dragon")
			-- vim.cmd.colorscheme("kanagawa-lotus")
		end,
	},
}
