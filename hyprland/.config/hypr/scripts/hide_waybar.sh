#!/usr/bin/env bash

waybar_config_file_original=$HOME/.config/waybar/config_original.jsonc
waybar_config_file=$HOME/.config/waybar/config.jsonc

if [ ! -f "$waybar_config_file" ]; then
  cp "$waybar_config_file_original" "$waybar_config_file"
fi

toggle_bar() {
  # Extract monitor name from hyprctl output (e.g., "DP-1" from "... on monitor DP-1:")
  active_monitor=$(hyprctl activeworkspace | awk -F'monitor ' 'NR==1{print $2}' | sed 's/:$//')

  if grep -q "\"$active_monitor""X\"" "$waybar_config_file"; then
    # Copy original file over tmp working file - doing it this way so
    # if I make changes to original file I can easily update the tmp working file
    cp "$waybar_config_file_original" "$waybar_config_file"
  elif grep -q "\"$active_monitor\"" "$waybar_config_file"; then
    # Append an X to active monitor name - this will make it invalid and will hide the bar on that display
    sed -i "s/\"$active_monitor\"/\"${active_monitor}X\"/g" "$waybar_config_file"
  else
    return 0
  fi
  # Refresh waybar configuration
  killall -SIGUSR2 waybar
}

toggle_bar
