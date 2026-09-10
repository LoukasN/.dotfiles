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
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
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
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters = {
					prettier = {
						prepend_args = { "--tab-width", "4" },
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					cs = { "clang_format" },
					css = { "prettier" },
					html = { "prettier" },
					markdown = { "prettier" },
					bash = { "beautysh" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
				},
			})
		end,
	},
}
