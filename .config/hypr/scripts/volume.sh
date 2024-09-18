#!/usr/bin/env sh

mute_verification=$(pamixer 2:-5 --get-mute | cat)
icons_dir="${HOME}/.config/hypr/scripts/icons/volume"


notify_volume() {  
  ico="${icons_dir}/vol-${volume}.svg"

  notify-send -i "${ico}" "${volume}"
}

notify_mute() {
  if [ ${mute_verification} == "false" ]; then
    notify-send -i "${icons_dir}/muted-speaker.svg" muted
    exit 1
  fi

  notify-send -i "${icons_dir}/unmuted-speaker.svg" unmuted
}

case "$1" in
  i)
    amixer sset Master 5%+
    volume=$(pamixer 2:-5 --get-volume | cat)
    notify_volume
    ;;
  d)
    amixer sset Master 5%-
    volume=$(pamixer 2:-5 --get-volume | cat)
    notify_volume
    ;;
  t)
    amixer sset Master toggle 
    notify_mute
    ;;
  *)
    ;;
esac
