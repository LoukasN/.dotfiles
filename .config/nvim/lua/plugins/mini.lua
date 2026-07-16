return {
	{
		"echasnovski/mini.nvim",
		enabled = true,
		version = false,
		config = function()
			require("mini.surround").setup({})
			require("mini.comment").setup({})
			require("mini.cursorword").setup({})
			require("mini.icons").setup({})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({
				completions = { lsp = { enabled = true } },
			})
		end,
		keys = {
			{ "<leader>pt", "<Cmd>RenderMarkdown toggle<CR>", desc = "Render as markdown", ft = "markdown" },
		},
	},
}
