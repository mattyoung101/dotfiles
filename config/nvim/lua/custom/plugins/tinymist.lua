return {
  -- add tinymist to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          settings = {
              systemFonts = false,
              formatterMode = "typstyle",
              previewFeature = "disable"
          }
        },
      },
    },
  },
}
