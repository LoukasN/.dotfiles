return {
	'ThePrimeagen/harpoon',
	config = function()
		require("telescope").load_extension('harpoon')
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>ah", mark.add_file, {desc = "Add harpoon"})
		vim.keymap.set("n", "<leader>ph", ui.toggle_quick_menu, {desc = "Harpoons"})

		vim.keymap.set("n", "<A-Tab>", ui.nav_next, {desc = "Next harpoon"})
		vim.keymap.set("n", "<A-S-Tab>", ui.nav_prev, {desc = "Previous harpoon"})

		vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end)
		vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end)
		vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end)
		vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end)
		vim.keymap.set("n", "<A-5>", function() ui.nav_file(5) end)
		vim.keymap.set("n", "<A-6>", function() ui.nav_file(6) end)
		vim.keymap.set("n", "<A-7>", function() ui.nav_file(7) end)
		vim.keymap.set("n", "<A-8>", function() ui.nav_file(8) end)
		vim.keymap.set("n", "<A-9>", function() ui.nav_file(9) end)
	end,
}
