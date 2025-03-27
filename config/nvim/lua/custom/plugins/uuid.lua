return {
    'TrevorS/uuid-nvim',
    lazy = true,
    cmd = { "Uuid" },
    config = function()
        -- optional configuration
        require('uuid-nvim').setup {
            case = 'lower',
            quotes = 'double',
        }

        vim.api.nvim_create_user_command('Uuid', function()
            require("uuid-nvim").insert_v4()
        end, {})
    end,
}
