#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
primary_monitor=$(xrandr --query | grep primary | cut -d" " -f1)
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar mainbar 2>&1 | tee -a /tmp/polybar_"$m".log &
	done
else
	polybar --reload example &
fi
disown
