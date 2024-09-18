#!/usr/bin/env sh

icons_dir="${HOME}/.config/hypr/scripts/icons/volume"



notify_brightness() {
  percentage=$(awk -v brightness="${brightness}" 'BEGIN { printf "%d", (brightness / 256) * 100 + 0.5 }')
  icon="${icons_dir}/vol-${percentage}.svg" 

  notify-send -i "${icon}" "${percentage}"
}


case "$1" in
  -i)
    brightnessctl set +5%
    brightness=$(brightnessctl get)
    notify_brightness
    ;;
  -d)
    brightnessctl set 5%-
    brightness=$(brightnessctl get)
    notify_brightness
    ;;
  *)
    echo "$0" commands:
    echo 
    echo "-i : increase the brightness"
    echo "-d : decrease the brightness"
    ;;
esac
