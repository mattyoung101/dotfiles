return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
        git_status = {
          symbols = {
            renamed   = "󰁕",
            unstaged  = "󰄱",
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
      },
      -- Other options ...
      source_selector = {
          winbar = true,
          statusline = false
      }
    })

    vim.keymap.set('n', '<leader>ftl', ":Neotree action=focus source=filesystem position=left toggle=true<cr>", { silent=true, desc="[F]iletree [T]oggle [L]eft" })
    vim.keymap.set('n', '<leader>ftr', ":Neotree action=focus source=filesystem position=right toggle=true<cr>", { silent=true, desc="[F]iletree [T]oggle [R]ight" })
    vim.keymap.set('n', '<leader>ftf', ":Neotree action=focus source=filesystem position=float toggle=true<cr>", { silent=true, desc="[F]iletree [T]oggle [F]loat" })
    vim.keymap.set('n', '<leader>fgl', ":Neotree action=focus source=git_status position=left toggle=true<cr>", { silent=true, desc="[F]iletree [G]it [L]eft" })
    vim.keymap.set('n', '<leader>fgr', ":Neotree action=focus source=git_status position=right toggle=true<cr>", { silent=true, desc="[F]iletree [G]it [R]ight" })
    vim.keymap.set('n', '<leader>fgf', ":Neotree action=focus source=git_status position=float toggle=true<cr>", { silent=true, desc="[F]iletree [G]it [F]loat" })
    vim.keymap.set('n', '<leader>fbl', ":Neotree action=focus source=buffers position=left toggle=true<cr>", { silent=true, desc="[F]iletree [B]uffers [L]eft" })
    vim.keymap.set('n', '<leader>fbr', ":Neotree action=focus source=buffers position=right toggle=true<cr>", { silent=true, desc="[F]iletree [B]uffers [R]ight" })
    vim.keymap.set('n', '<leader>fbf', ":Neotree action=focus source=buffers position=float toggle=true<cr>", { silent=true, desc="[F]iletree [B]uffers [F]loat" })
  end,
}
