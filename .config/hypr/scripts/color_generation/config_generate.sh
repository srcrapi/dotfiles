#!/usr/bin/env sh

save_dir="${HOME}/.config/swww"
wall_dir="${HOME}/Pictures/wallpapers"
waybar_config="${HOME}/.config/waybar/config.jsonc"
cache_dir="${HOME}/.cache/material-colors"
swww_cache_dir="${save_dir}/.cache"
generate_material_colors="${HOME}/.config/hypr/scripts/color_generation/generate_material_colors.py"

wallpaper_location="$(ls "${wall_dir}" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)"


config_gen() {
  darkmode=$(jq -r ".darkmode" "${cache_dir}"/config.json )

  if [ "${darkmode}" = "true" ]; then
    mode="dark"
	jq '.neovim_colorscheme = "catppuccin-mocha"' "${cache_dir}/config.json" > /tmp/config.json
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
	pywal-discord -t default 
	cp -r ~/.config/Vencord/themes/pywal-discord-default.theme.css ~/.config/vesktop/themes
	swaync-client -rs 

	if pgrep -x spotify > /dev/null ; then
		pkill -x spicetify
		spicetify -q watch -s &
	fi

	sleep 0.5
	pkill waybar
	sleep 0.5

	waybar > /dev/null &
	pkill -USR2 cava

	sleep 0.5

	notify-send -t 4500 "Theme and walpaper updated" "With image ${wallpaper_location}"
}

wall
