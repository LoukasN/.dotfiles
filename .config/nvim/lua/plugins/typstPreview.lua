return {
    'chomosuke/typst-preview.nvim',
    lazy = false,
    version = '1.*',
    opts = {},
    vim.keymap.set("n", "<leader>pt", "<CMD>TypstPreview<CR>"),
}
