return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>ah", function() harpoon:list():add() end, {desc = "Add harpoon"})
		vim.keymap.set("n", "<leader>ph", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoons"})

		vim.keymap.set("n", "<A-Tab>", function() harpoon:list():next() end, {desc = "Next harpoon"})
		vim.keymap.set("n", "<A-S-Tab>", function() harpoon:list():prev() end, {desc = "Previous harpoon"})

		vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
		vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
		vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
		vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
		vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end)
		vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end)
	end,
}
