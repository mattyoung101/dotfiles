return {
  "camspiers/luarocks",
  dependencies = {
    "rcarriga/nvim-notify", -- Optional dependency
  },
  opts = {
    rocks = { "magick" } -- Specify LuaRocks packages to install
  }
}
