return {
  name = "typst watch",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "typst", "watch" },
      args = { file },
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "typst", "typ" },
  },
}
