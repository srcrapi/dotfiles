#!/usr/bin/env sh

color=$(hyprpicker --autocopy)

if [ -z ${color} ]; then
  exit 0
fi

notify-send -t 3500 "${color} color saved to the clipboard"
