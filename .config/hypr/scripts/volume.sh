#!/usr/bin/env bash

mute_verification=$(pamixer --get-mute)
icons_dir="${HOME}/.config/hypr/scripts/icons/volume"


notify_mute() {
	if [ ${mute_verification} == "false" ]; then
		notify-send -i "${icons_dir}/muted-speaker.svg" muted
		exit 1
	fi

	notify-send -i "${icons_dir}/unmuted-speaker.svg" unmuted
}

send_notification() {
	volume=$(pamixer --get-volume)
	ico="${icons_dir}/vol-${volume}.svg"

	notify-send -i "${ico}" "${volume}"
}


case "$1" in
  i)
	pamixer -u
	pamixer -i 5 --allow-boost
	send_notification
    ;;
  d)
	pamixer -u
	pamixer -d 5 --allow-boost
	send_notification
    ;;
  t)
	pamixer -t
	notify_mute
    ;;
  *)
    ;;
esac
