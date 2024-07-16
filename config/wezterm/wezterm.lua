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

-- Get the machine hostname
-- Source: https://gist.github.com/h1k3r/089d43771bdf811eefe8
function getHostname()
    local f = io.popen ("hostname")
    local hostname = f:read("*a") or ""
    f:close()
    hostname =string.gsub(hostname, "\n$", "")
    return hostname
end

config.warn_about_missing_glyphs = false

-- This is where you actually apply your config choice
config.font = wezterm.font 'DejaVuSansM Nerd Font Mono'
config.freetype_load_target = 'HorizontalLcd'
-- disable ligatures (combining <= into a single symbol): https://wezfurlong.org/wezterm/config/font-shaping.html#advanced-font-shaping-options
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
-- https://github.com/wez/wezterm/issues/3774#issuecomment-1629689265
config.freetype_load_flags = 'NO_HINTING'

-- host specific ugly hack
-- we don't really want to make the whole wezterm lua a host-specific file with rcm, we just want different
-- font sizes
-- so, we query the machine hostname and put our host specific code here!
if getHostname() == 'EMT-LPT-095-LNX' or getHostname() == 'EMT-LPT-144' then
    -- work laptops
    config.font_size = 11.0
else
    -- serpent or gecko
    config.font_size = 10.0
end

-- doesn't seem to be necessary, was a font thing
config.front_end = "OpenGL"
-- attempt to fix latency (not very successful)
-- see: https://github.com/wez/wezterm/issues/4052#issuecomment-2004400745
config.max_fps = 255

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

-- check for Windows work laptop: has a different artwork location
if getHostname() == 'EMT-LPT-144' then
    BackgroundPath = 'C:\\Users\\matt.young\\.dotfiles\\config\\dotfiles-artwork\\_c__squid_plushie___by_ruruko01_dg5ftuw-fullview-nvim2.jpg'
else
    BackgroundPath = '/home/matt/.config/dotfiles-artwork/_c__squid_plushie___by_ruruko01_dg5ftuw-fullview-nvim2.jpg'
end

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
            File = BackgroundPath
        },
        opacity = 0.05,
        vertical_align = "Bottom" -- me fr
    }
}

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window {}
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
    active_titlebar_bg = '#0b0d15',

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#0b0d15',
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
    {
        key = '{',
        mods = 'SHIFT|ALT',
        action = wezterm.action.MoveTabRelative(-1)
    },
    {
        key = '}',
        mods = 'SHIFT|ALT',
        action = wezterm.action.MoveTabRelative(1)
    },
}

-- https://www.reddit.com/r/wezterm/comments/10jda7o/is_there_a_way_not_to_open_urls_on_simple_click/
config.mouse_bindings = {
    -- Disable the default click behavior
    {
      event = { Up = { streak = 1, button = "Left"} },
      mods = "NONE",
      action = wezterm.action.DisableDefaultAssignment,
    },
    -- Ctrl-shift-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL|SHIFT",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
    -- Disable the Ctrl-shift-click down event to stop programs from seeing it when a URL is clicked
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL|SHIFT",
        action = wezterm.action.Nop,
    },
}

-- Padding seems to look fine on desktop machines, only clear it on the laptop
-- if getHostname() == 'gecko' then
--     -- clear padding
--     config.window_padding = {
--         left = 0,
--         top = 0,
--         bottom = 0,
--         right = 0
--     }
-- end

-- and finally, return the configuration to wezterm
return config
