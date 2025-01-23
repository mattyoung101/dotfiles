return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require('aerial').setup {
            vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>"),
            backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
            filter_kind = false,
            lazy_load = true
        }

        require("telescope").setup({
            extensions = {
                aerial = {
                    -- Set the width of the first two columns (the second
                    -- is relevant only when show_columns is set to 'both')
                    col1_width = 4,
                    col2_width = 30,
                    -- How to format the symbols
                    format_symbol = function(symbol_path, filetype)
                        if filetype == "json" or filetype == "yaml" then
                            return table.concat(symbol_path, ".")
                        else
                            return symbol_path[#symbol_path]
                        end
                    end,
                    -- Available modes: symbols, lines, both
                    show_columns = "both",
                },
            },
        })

        require("telescope").load_extension("aerial")


        vim.keymap.set('n', '<leader>sa', require("telescope").extensions.aerial.aerial, { desc = '[S]earch [A]erial' })
    end,
}
