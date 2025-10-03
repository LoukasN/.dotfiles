return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			explorer = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = "", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				},
			},
		},
	},
	vim.keymap.set("n", "<leader>n", "<cmd>lua Snacks.explorer()<CR>", { desc = "Open file explorer" }),
	vim.keymap.set("n", "<leader>lg", "<cmd>lua Snacks.lazygit()<CR>", { desc = "Open lazygit" }),
}
