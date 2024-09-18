#!/usr/bin/env sh

waybar_dir="${HOME}/.config/waybar"
conf_ctl="$waybar_dir/config.ctl"
in_file="$waybar_dir/modules/style.css"
out_file="$waybar_dir/style.css"

export w_position=`grep "^1|" $conf_ctl | cut -d "|" -f 6`

case "$w_position" in
	top)
		w_position="bottom"
		export w_position1="bottom"
		export r_margin="bottom"
		;;
	bottom)
		w_position="top"
		export w_position1="top"
		export r_margin="top"
		;;
	left)
		export w_side="right"
		export w_side1="right"
		;;
	right)
		export w_side="left"
		export w_side1="left"
		;;
esac

case "$w_position" in
	top|bottom)
		export w_side="left"
		export w_side1="right"
		;;
	left|right)
		w_position="top"
		export w_position1="bottom"
		;;
esac

envsubst < "$in_file" > "$out_file"
