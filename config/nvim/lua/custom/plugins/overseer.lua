return {
    'stevearc/overseer.nvim',
    opts = {},
    lazy = true,
    event = "VeryLazy",
    keys = {
        {
            "<leader>ot",
            "<cmd>OverseerToggle<cr>",
            desc = "[O]verseer [T]oggle",
        }
    },
    config = function()
        require("overseer").setup({
            templates = { "builtin", "user.typst_watch", "user.typst_thesis" },
        })
    end
}
