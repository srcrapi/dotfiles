#!/usr/bin/env sh

save_dir="${HOME}/.config/swww"
wall_dir="${HOME}/Pictures/wallpapers"
wall_select="${HOME}/.config/rofi/wallselect.rasi"
waybar_config="${HOME}/.config/waybar/config.jsonc"
cache_dir="${HOME}/.cache/material-colors"
swww_cache_dir="${save_dir}/.cache"
generate_material_colors="${HOME}/.config/hypr/scripts/color_generation/generate_material_colors.py"


case "$1" in
	"")
		wallpaper_location=$(for a in "$wall_dir"/*; do echo -en "$(basename "$a")\0icon\x1f$a\n" ; done | rofi -dmenu -theme "$wall_select")
		echo "${wallpaper_location}"
		;;
	*)
		wallpaper_location=$(basename "$1")
		;;
esac


config_gen() {
  darkmode=$(jq -r ".darkmode" "${cache_dir}"/config.json )

  if [ "${darkmode}" = "true" ]; then
    mode="dark"
	jq '.neovim_colorscheme = "sakura"' "${cache_dir}/config.json" > /tmp/config.json
	mv /tmp/config.json "${cache_dir}/config.json"

	sed -i "s/black/white/g" "${waybar_config}"
  else
    mode="light"
	jq '.neovim_colorscheme = "catppuccin-latte"' "${cache_dir}/config.json" > /tmp/config.json
	mv /tmp/config.json "${cache_dir}/config.json"

	sed -i "s/white/black/g" "${waybar_config}"
  fi

  scheme=$(jq -r ".scheme" "${cache_dir}"/config.json )
  opaque=$(jq -r ".opaque" "${cache_dir}"/config.json )

  if [ "${opaque}" = "true" ]; then
    transparency="opaque"
  else
    transparency="transparent"
  fi

  python "${generate_material_colors}" --path "${wall_dir}/${wallpaper_location}"\
    --scheme "${scheme}" --mode "${mode}" --transparency "${transparency}" > "${cache_dir}/material-colors.scss"

	"${HOME}/.config/hypr/scripts/color_generation/apply_colors.sh"
	python "${HOME}/.local/bin/hypr_config_gen.py"
}


wall() {
  wallpaper_name=$(basename "${wallpaper_location%.*}")

  if [ ! -f "${wall_dir}/${wallpaper_location}" ]; then
    echo The file doesn\'t exist
    exit 1
  fi

  if [ ! -f "${swww_cache_dir}" ]; then
    mkdir -p "${swww_cache_dir}"
  fi

  if [ ! -f "${wallpaper_name}_blur.png" ]; then
    magick "${wall_dir}/${wallpaper_location}" -blur 0x2 "${swww_cache_dir}/${wallpaper_name}_blur.png"
  fi

	ln -fs "${wall_dir}/${wallpaper_location}" "${save_dir}/wall.set"
	ln -fs "${swww_cache_dir}/${wallpaper_name}_blur.png" "${save_dir}/wall.blur"

	wal -s -i "${wall_dir}/${wallpaper_location}" > /dev/null
	config_gen

	swww img "${save_dir}/wall.set" --transition-fps 120 --transition-type grow \
		--transition-duration 1 --transition-pos bottom-right

	pywalfox update
	swaync-client -rs 

	if pgrep -x spotify > /dev/null ; then
		pkill -x spicetify
		spicetify -q watch -s &
	fi

	#sleep 0.5
	#pkill waybar
	#pgrep -x ags && pkill -x gjs 
	#sleep 0.5

	#waybar > /dev/null &
	#ags run &
	goignis reload
	pkill -USR2 cava

	sleep 0.5

	notify-send -t 4500 "Theme and walpaper updated" "With image ${wallpaper_location}"
}

wall
