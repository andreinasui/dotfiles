------------------------
---- MY PROGRAMS ----
------------------------

return {
	terminal = "kitty",
	menu = 'wofi --show drun -i -p "Search"',
	powermenu = "$HOME/.config/hypr/scripts/powermenu.sh",
	hyprshot = "$HOME/.config/hypr/scripts/hyprshot/hyprshot",

	-- TODO: try to do this from lua instead of sh script
	hide_waybar = "$HOME/.config/hypr/scripts/hide_waybar.sh",

	browser = "zen-browser",
	discord = "flatpak run dev.vencord.Vesktop",
	teams = "flatpak run com.github.IsmaelMartinez.teams_for_linux ",
	spotify = "flatpak run com.spotify.Client",

	mainMod = "SUPER",
}
