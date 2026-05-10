-- See https://wiki.hyprland.org/Configuring/Keywords/

local vars = require("modules.variables")
local terminal = vars.terminal
local menu = vars.menu
local powermenu = vars.powermenu
local hide_waybar = vars.hide_waybar
local mainMod = vars.mainMod

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(powermenu))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
-- Reload waybar
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))
-- Hide waybar
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd(hide_waybar))
hl.bind(mainMod .. " + P", hl.dsp.workspace.move({ monitor = "+1", follow = true }))
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'IMG=$HOME/Screenshots/"$(date +\'%Y-%m-%d-%H%M%S_screenshot.png\')" && grim -g "$(slurp -w 0 -b 00000088)" $IMG && wl-copy < $IMG && notify-send "Screenshot taken" "Image copied to the clipboard\nImage saved to $IMG" -t 5000 -i $IMG -a Screenshot'
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		'IMG=$HOME/Screenshots/"$(date +\'%Y-%m-%d-%H%M%S_screenshot.png\')" && grim -g "$(slurp -w 0 -b 00000088)" - | swappy -f - -o $IMG && wl-copy < $IMG && notify-send "Screenshot taken" "Image copied to the clipboard\nImage saved to $IMG" -t 5000 -i $IMG -a Screenshot'
	)
)

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
-- hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd('playerctl --player="spotify" next'), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd('playerctl --player="spotify" play-pause'), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd('playerctl --player="spotify" play-pause'), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd('playerctl --player="spotify" previous'), { locked = true })
