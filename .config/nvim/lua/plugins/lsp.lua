return {
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
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"pylsp",
						"lua_ls",
						"clangd",
						"bashls",
						"ts_ls",
						"gopls",
					},
					auto_install = false,
				},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})
			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})
			vim.lsp.config("pylsp", {
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
			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})
			vim.lsp.config("tinymist", {
				capabilities = capabilities,
				offset_encoding = "utf-8",
				formatterMode = "typstyle",
			})
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("emmet_ls", {
				capabilities = capabilities,
				filetypes = { "html", "css", "jsx", "tsx", "javascriptreact", "typescriptreact" },
			})

			vim.lsp.config("qmlls", {
				capabilities = capabilities,
			})

			vim.lsp.config("csharp_ls", {
				capabilities = capabilities,
				filetypes = { "cs" },

				root_dir = function(bufnr, on_dir)
					local root = vim.fs.root(bufnr, {
						".slnx",
						".sln",
						".csproj",
						"ProjectSettings",
					})

					if root then
						on_dir(root)
					end
				end,
			})

			vim.lsp.enable({
				"lua_ls",
				"clangd",
				"bashls",
				"pylsp",
				"gopls",
				"tinymist",
				"ts_ls",
				"emmet_ls",
				"csharp_ls",
			})

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show information", silent = true })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })
		end,
	},
}
