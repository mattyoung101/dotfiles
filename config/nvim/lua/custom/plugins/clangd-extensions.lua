return {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    ft = "cpp",
    config = function()
        require("clangd_extensions").setup {}
    end,
}
