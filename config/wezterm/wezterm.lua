-- https://wezterm.org
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.color_scheme = 'Catppuccin Macchiato'
config.colors = {
    background = "#1f2029",
    -- cursor_bg = "#EEEEEE",
}

config.enable_tab_bar = false
config.window_background_opacity = 0.9
-- config.window_decorations = "RESIZE"
-- config.default_prog = {"bash",}

config.keys = {
    { key = 'Return', mods = 'ALT',       action = wezterm.action.SpawnWindow },
    { key = 'f',      mods = 'ALT|CTRL',  action = wezterm.action.SpawnCommandInNewWindow { args = { 'lf' }, }, },
    { key = 'f',      mods = 'ALT|SHIFT', action = wezterm.action.SpawnCommandInNewWindow { args = { 'lf' }, }, },
    { key = 'e',      mods = 'ALT|CTRL',  action = wezterm.action.SpawnCommandInNewWindow { args = { 'nvim', '.' }, }, },
    { key = 'e',      mods = 'ALT|SHIFT', action = wezterm.action.SpawnCommandInNewWindow { args = { 'nvim', '.' }, }, },
}

return config
