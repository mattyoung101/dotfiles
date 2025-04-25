return {
  "00msjr/nvim-fountain",
  ft = "fountain",  -- Lazy-load only for fountain files
  config = function()
    require("nvim-fountain").setup({
      -- Optional configuration
      keymaps = {
        next_scene = "<leader>ns",
        prev_scene = "<leader>ps",
        uppercase_line = "<S-CR>",
      },
      -- Export configuration
      export = {
        pdf = { options = "--overwrite" },
      },
    })
  end,
}
