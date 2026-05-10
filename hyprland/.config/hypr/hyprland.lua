require("modules.monitors")
require("modules.general")
require("modules.binds")
require("modules.rules")
require("modules.env")

local vars = require("modules.variables")
local terminal = vars.terminal
local browser = vars.browser
local discord = vars.discord
local teams = vars.teams
local spotify = vars.spotify

local gnomeSchema = "org.gnome.desktop.interface"

hl.on("hyprland.start", function()
	hl.exec_cmd(terminal, { workspace = 1 })
	hl.exec_cmd(browser, { workspace = 2 })
	hl.exec_cmd(teams, { workspace = 3 })
	hl.exec_cmd(spotify)
	hl.exec_cmd(discord)
	hl.exec_cmd("steam")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
	hl.exec_cmd("cb")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("polychromatic-tray-applet")
	hl.exec_cmd("kdeconnectd")
	hl.exec_cmd("kdeconnect-indicator")
	hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("gsettings set " .. gnomeSchema .. ' gtk-theme "Gruvbox-Material-Dark"')
	hl.exec_cmd("gsettings set " .. gnomeSchema .. ' icon-theme "Gruvbox-Material-Dark"')
	hl.exec_cmd("gsettings set " .. gnomeSchema .. ' cursor-theme "Gruvbox-Material-Dark"')
	hl.exec_cmd("gsettings set " .. gnomeSchema .. ' font-name "Gruvbox-Material-Dark"')
	hl.exec_cmd("gsettings set " .. gnomeSchema .. ' color-scheme "prefer-dark"')
	-- For screenshare
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
