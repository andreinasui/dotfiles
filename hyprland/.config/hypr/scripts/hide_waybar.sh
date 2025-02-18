#!/usr/bin/env bash

waybar_config_file_original=$HOME/.config/waybar/config_original.jsonc
waybar_config_file=$HOME/.config/waybar/config.jsonc

if [ ! -f "$waybar_config_file" ]; then
	cp "$waybar_config_file_original" "$waybar_config_file"
fi

toggle_bar() {
	active_monitor=$(hyprctl activeworkspace | awk 'NR==1{sub(/:/, ""); print $NF }')
	if grep -q "$active_monitor""0" "$waybar_config_file"; then
		# Remove the 0 from active monitor name - this will make it valid and will show the bar on that display
		sed -i -E "/^ *\"output\": *\[.*\"""$active_monitor""0\".*\],$/s/""$active_monitor""0/$active_monitor/g" "$waybar_config_file"
	elif grep -q "$active_monitor" "$waybar_config_file"; then
		# Append a 0 to active monitor nam - this will make it invalid and will hide the bar on that displaye
		sed -i -E "/^ *\"output\": *\[.*\"$active_monitor\".*\],$/s/$active_monitor/\00/g" "$waybar_config_file"
	else
		return 0
	fi
	# Refresh waybar configuration
	killall -SIGUSR2 waybar
}

toggle_bar
