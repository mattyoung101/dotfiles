return {
    "chrisgrieser/nvim-spider",
    version = "*",
    config = function()
        require("spider").setup {
            skipInsignificantPunctuation = false,
            subwordMovement = true,
        }
        vim.keymap.set(
            { "n", "o", "x" },
            "w",
            "<cmd>lua require('spider').motion('w')<CR>",
            { desc = "Spider-w" }
        )
        vim.keymap.set(
            { "n", "o", "x" },
            "e",
            "<cmd>lua require('spider').motion('e')<CR>",
            { desc = "Spider-e" }
        )
        vim.keymap.set(
            { "n", "o", "x" },
            "b",
            "<cmd>lua require('spider').motion('b')<CR>",
            { desc = "Spider-b" }
        )
        -- reference: https://github.com/chrisgrieser/nvim-spider/issues/21
        vim.keymap.set({ "n", "o", "x" }, "b", function() require("spider").motion("b") end, { desc = "Spider-b" })
        vim.keymap.set("i", "<C-w>", "<Esc>cvb", { remap = true })
    end
}
