return {
    'akinsho/git-conflict.nvim',
    tag = 'v2.1.0',
    lazy = true,
    event = "VeryLazy",
    config = function()
        require('git-conflict').setup {}
    end,
}
