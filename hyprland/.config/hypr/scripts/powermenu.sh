#!/bin/bash

# Options for powermenu
logout="    Logout"
shutdown="    Shutdown"
reboot="    Reboot"
sleep="    Sleep"

# Get answer from user via rofi
selected_option=$(
  echo "$logout
$sleep
$reboot
$shutdown" | wofi -dmenu -i -p "Power"
)

# Do something based on selected option
if [ "$selected_option" == "$logout" ]; then
  hyprshutdown
elif [ "$selected_option" == "$shutdown" ]; then
  hyprshutdown -t "Shutting down..." --post-cmd 'systemctl poweroff'
elif [ "$selected_option" == "$reboot" ]; then
  hyprshutdown -t "Restarting" --post-cmd 'systemctl poweroff'
elif [ "$selected_option" == "$sleep" ]; then
  systemctl suspend
else
  echo "No match"
fi
