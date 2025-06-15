return {
    'akinsho/git-conflict.nvim',
    lazy = true,
    event = "VeryLazy",
    config = function()
        require('git-conflict').setup {}
    end,
}
