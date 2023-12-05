#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar -q main -c "$DIR"/kessoku_bar/config.ini &

if [[ $(xrandr -q | grep 'HDMI-1 connected') ]]; then
	polybar -q external -c "$DIR"/kessoku_bar/config.ini &
fi
