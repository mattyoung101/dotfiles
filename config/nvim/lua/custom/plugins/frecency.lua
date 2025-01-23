return {
    "nvim-telescope/telescope-frecency.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("telescope").load_extension "frecency"
    end,
}
