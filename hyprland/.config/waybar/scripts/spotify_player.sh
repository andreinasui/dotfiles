#!/bin/sh
player=spotify
player_status=$(playerctl --player=$player status 2>/dev/null)
if [ "$player_status" = "Playing" ]; then
	echo "$(playerctl --player=$player metadata artist) - $(playerctl --player=$player metadata title)"
elif [ "$player_status" = "Paused" ]; then
	echo " $(playerctl --player=$player metadata artist) - $(playerctl --player=$player metadata title)"
fi
