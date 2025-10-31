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
            explorer = {
                enabled = true,
            },
            picker = {
                enabled = true,
            },
            dashboard = {
                enabled = false,
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { icon = "", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                },
            },
        },
        keys = {
            { "<leader>pf", function() Snacks.picker.files() end, desc = "Preview files" },
            { "<leader>pg", function() Snacks.picker.grep() end, desc = "Grep files" },
            { "<leader>pq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>pb", function() Snacks.picker.buffers() end, desc = "Preview buffers" },
            { "<leader>ps", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<leader>pS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
            { "<leader>pc", function() Snacks.picker.colorschemes() end, desc = "Preview colorschemes" },
            { "<leader>h", function() Snacks.picker.help() end, desc = "Preview colorschemes" },
            { "<leader>n", function() Snacks.explorer() end, desc = "Open file explorer" },
            { "<leader>lg", function() Snacks.lazygit() end, desc = "Open lazygit" },
        },
    },
}
