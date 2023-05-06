return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- Setup
    }
    -- Exclude dashboard from indent lines
    vim.g.indent_blankline_filetype_exclude = {'dashboard'}
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
