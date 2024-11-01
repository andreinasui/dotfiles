#!/usr/bin/env bash

# compositor
mkdir -p "$HOME"/.local/state/picom
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/picom/picom.conf &

# notifications - dunst
killall dunst
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done
dunst &

# corectrl - amd gpu oc
killall corectrl
while pgrep -u $UID -x corectrl >/dev/null; do sleep 1; done
corectrl &
