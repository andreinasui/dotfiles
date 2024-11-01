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
	hyprctl dispatch exit
elif [ "$selected_option" == "$shutdown" ]; then
	systemctl poweroff
elif [ "$selected_option" == "$reboot" ]; then
	systemctl reboot
elif [ "$selected_option" == "$sleep" ]; then
	systemctl suspend
else
	echo "No match"
fi
