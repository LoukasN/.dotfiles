return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
		init = function()
			local ensureInstalled = {
				"lua",
				"c",
				"cpp",
				"go",
				"css",
				"html",
				"python",
				"markdown",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parserToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parserToInstall)
		end
	end,
}
