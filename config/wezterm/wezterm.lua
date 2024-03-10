-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choice
config.font = wezterm.font 'DejaVuSansM Nerd Font Mono'
config.freetype_load_target = 'HorizontalLcd'
-- disable ligatures (combining <= into a single symbol): https://wezfurlong.org/wezterm/config/font-shaping.html#advanced-font-shaping-options
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 10.0
-- https://github.com/wez/wezterm/issues/3774#issuecomment-1629689265
config.freetype_load_flags = 'NO_HINTING'

-- doesn't seem to be necessary, was a font thing
config.front_end = "OpenGL"

-- scrolling, unlimited scrollback not yet supported (according to GH issues it's more complicated!)
config.enable_scroll_bar = true
config.scrollback_lines = 10000

-- Kanagawa Nvim colour scheme
config.colors = {
    foreground = "#dcd7ba",
    background = "#1f1f28",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#2d2d3d",
    split = "#16161d",

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

config.background = {
    -- first, the background colour
    {
        source = {
            Color = config.colors.background
        },
        width = "100%",
        height = "100%",
    },
    -- now, our catboy with very low opacity
    {
        source = {
            File = '/home/matt/.config/dotfiles-artwork/_c__squid_plushie___by_ruruko01_dg5ftuw-fullview-nvim.jpg'
        },
        opacity = 0.05,
    }
}

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  --font = wezterm.font { family = 'JetBrainsMono Nerd Font Mono', weight = 'Bold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 10.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
}

config.keys = {
  -- This will create a new split and run your default program inside it
  {
    key = '"',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = ':',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
}


-- and finally, return the configuration to wezterm
return config

