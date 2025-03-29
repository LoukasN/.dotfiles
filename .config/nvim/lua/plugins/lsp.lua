return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"pylsp",
				"lua_ls",
				"clangd",
				"bashls",
			},
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			-- If using cmp_nvim
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- If using blink
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.zls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { "W391" },
								maxLineLength = 100,
							},
						},
					},
				},
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.sqls.setup({
				capabilities = capabilities,
			})
			lspconfig.vhdl_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tinymist.setup({
				capabilities = capabilities,
				offset_encoding = "utf-8",
			})
			lspconfig.taplo.setup({
				capabilities = capabilities,
			})
			lspconfig.matlab_ls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "<leader>gd", require('telescope.builtin').lsp_definitions, { desc = "Go to definition" })
			vim.keymap.set("n", "<leader>gi", require('telescope.builtin').lsp_implementations, { desc = "Go to implementation" })
			vim.keymap.set("n", "<leader>gr", require('telescope.builtin').lsp_references, { desc = "Go to references" })
			vim.keymap.set("n", "<leader>ds", require('telescope.builtin').lsp_document_symbols, { desc = "Document symbols" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show information" })
		end,
	},
}
