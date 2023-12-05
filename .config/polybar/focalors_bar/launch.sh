#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar -q left -c "$DIR"/focalors_bar/config.ini &
polybar -q middle -c "$DIR"/focalors_bar/config.ini &
polybar -q right -c "$DIR"/focalors_bar/config.ini &

if [[ $(xrandr -q | grep 'HDMI-1 connected') ]]; then
	polybar -q left_external -c "$DIR"/focalors_bar/config.ini &
	polybar -q middle_external -c "$DIR"/focalors_bar/config.ini &
	polybar -q right_external -c "$DIR"/focalors_bar/config.ini &
fi
