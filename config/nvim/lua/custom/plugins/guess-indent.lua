return {
    'nmac427/guess-indent.nvim',
    lazy = true,
    event = "VeryLazy",
    config = function()
        require('guess-indent').setup {}
    end,
}
