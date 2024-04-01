return {
  "simrat39/symbols-outline.nvim",
  version = "*",
  config = function ()
    require('symbols-outline').setup {}

    vim.keymap.set('n', '<leader>st', ":SymbolsOutline<cr>", { silent=true, desc="[S]ymbol Outline [T]oggle" })
  end,
}
