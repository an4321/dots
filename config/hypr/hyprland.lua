hl.monitor({ output = "", mode = "preferred", scale = 1.2 })

hl.on("hyprland.start", function ()
	hl.exec_cmd("setbg")
	hl.exec_cmd("waybar -c ~/.config/hypr/lib/waybar.jsonc -s ~/.config/hypr/lib/waybar.css")
	hl.exec_cmd("dunst --config ~/.config/hypr/lib/dunstrc")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("nm-applet")
end)

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 8,
		border_size = 0,
		resize_on_border = true,
		layout = "scrolling",
	},
	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1,
		},
	},
	animations = { enabled = true },
})

hl.config({
	scrolling = {
		column_width = 0.8,
		focus_fit_method = 0,
		fullscreen_on_one_column = false,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
	input = {
		kb_layout = "us",
		follow_mouse = 2,
		sensitivity = 0,
		touchpad = { natural_scroll = true },
		follow_mouse = 1,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "scroll_move",
	scale = 2.5,
})
hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "workspace",
	scale = 2.0,
})

hl.bind("ALT + r", hl.dsp.exec_cmd("rofi -config ~/.config/hypr/lib/rofi.rasi -show run"))
hl.bind("ALT + v", hl.dsp.exec_cmd("cliphist list | rofi -config ~/.config/hypr/lib/rofi.rasi " ..
	"-dmenu -p cliphist | awk '{print $1}' | xargs -r cliphist decode | wl-copy"))
hl.bind("ALT + SHIFT + r", hl.dsp.exec_cmd("setbg"))
hl.bind("ALT + t", hl.dsp.exec_cmd("kitty ~/Desktop"))
hl.bind("ALT + e", hl.dsp.exec_cmd("kitty nvim ~/Desktop"))
hl.bind("ALT + p", hl.dsp.exec_cmd("kitty htop"))
hl.bind("ALT + q", hl.dsp.window.close())
hl.bind("ALT + w", hl.dsp.exec_cmd("helium"))
hl.bind("ALT + SHIFT + w", hl.dsp.exec_cmd("helium --incognito"))
hl.bind("ALT + SHIFT + e", hl.dsp.exec_cmd("nautilus"))
hl.bind("ALT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + escape", hl.dsp.exec_cmd("lock"))
hl.bind("ALT + z", hl.dsp.dpms({ action = "toggle" }))
hl.bind("ALT + c", hl.dsp.exec_cmd("sh -c 'f=~/Pictures/screenshots/$(date +%F_%H-%M-%S).png; grim -g \"$(slurp)\" $f'"))
hl.bind("ALT + SHIFT + c", hl.dsp.exec_cmd("sh -c 'f=~/Pictures/screenshots/$(date +%F_%H-%M-%S).png; grim $f"))

hl.bind("ALT + h", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + l", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + k", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + j", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + SHIFT + h", hl.dsp.layout("swapcol l"))
hl.bind("ALT + SHIFT + l", hl.dsp.layout("swapcol r"))

hl.bind("ALT + i", hl.dsp.layout("colresize +0.1"))
hl.bind("ALT + u", hl.dsp.layout("colresize -0.1"))
hl.bind("ALT + bracketleft", hl.dsp.layout("consume_or_expel prev"))
hl.bind("ALT + bracketright", hl.dsp.layout("consume_or_expel next"))

for i, key in ipairs({"a", "s", "d", "f", "g"}) do
	hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- animations
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 220, dampening = 32 })
hl.animation({ leaf = "global", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 5.5, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, spring = "easy", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 92%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 4.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.2, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.2, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.2, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 8, bezier = "easeOutQuint" })
