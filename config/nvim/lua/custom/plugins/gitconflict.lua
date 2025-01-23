return {
    'akinsho/git-conflict.nvim',
    version = "*",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require('git-conflict').setup {}
    end,
}
