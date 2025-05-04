return {
    'pest-parser/pest.vim',
    opts = {},
    lazy = true,
    ft = "pest",
    config = function()
        require('pest-vim').setup {}
    end
}
