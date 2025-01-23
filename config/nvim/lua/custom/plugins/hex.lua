return {
    'RaafatTurki/hex.nvim',
    lazy = true,
    event = "VeryLazy",
    version = "*",
    config = function()
        require('hex').setup {}
    end,
}
