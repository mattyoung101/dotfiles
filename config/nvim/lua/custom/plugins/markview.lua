return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function ()
        require("markview").setup {
            typst = {
                code_blocks = {
                    enable = false
                }
            }
        }
    end
};
