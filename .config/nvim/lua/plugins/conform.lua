return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>ff",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier" },
				sql = { "sqlfmt" },
				bash = { "beautysh" },
				ruby = { "rubyfmt" },
			},
		})
	end,
}
