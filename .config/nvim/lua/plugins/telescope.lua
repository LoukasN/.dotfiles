return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			pcall(require("telescope").load_extension, "fzf")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Grep in files" })
			-- Show buffers with telescope
			vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Show open buffers" })
			vim.keymap.set("n", "<leader>ps", builtin.lsp_document_symbols, { desc = "Show symbols" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"debugloop/telescope-undo.nvim",
		config = function()
			require("telescope").load_extension("undo")
			vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Show undo menu" })
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		dependencies = { "nvim-lua/popup.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = "Change directory" })
		end,
	},
}
