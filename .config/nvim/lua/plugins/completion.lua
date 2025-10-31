return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},

	{
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
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					typst = { "typstyle" },
				},
			})
		end,
	},
}
