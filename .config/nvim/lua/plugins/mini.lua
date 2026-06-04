return {
	"echasnovski/mini.nvim",
	enabled = true,
	version = false,
	config = function()
		require("mini.surround").setup({})
		require("mini.comment").setup({})
		require("mini.cursorword").setup({})
		require("mini.icons").setup({})
	end,
}
