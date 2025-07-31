#!/usr/bin/env sh

cache_dir="${HOME}/.cache/material-colors"
generate_material_colors="${HOME}/.config/hypr/scripts/color_generation/generate_material_colors.py"
waybar_config="${HOME}/.config/waybar/config.jsonc"

darkmode=$(jq -r ".darkmode" "${cache_dir}"/config.json )

if [ "${darkmode}" = "true" ]; then
	mode="dark"
	jq '.neovim_colorscheme = "sakura"' "${cache_dir}/config.json" > /tmp/config.json
	mv /tmp/config.json "${cache_dir}/config.json"
else
	mode="light"
	jq '.neovim_colorscheme = "catppuccin-latte"' "${cache_dir}/config.json" > /tmp/config.json
	mv /tmp/config.json "${cache_dir}/config.json"
fi

scheme=$(jq -r ".scheme" "${cache_dir}"/config.json )
opaque=$(jq -r ".opaque" "${cache_dir}"/config.json )

if [ "${opaque}" = "true" ]; then
  transparency="opaque"
else
  transparency="transparent"
fi

wallpaper=$(swww query | cut -d ":" -f5 | xargs | cut -d " " -f1)

python "${generate_material_colors}" --path "${wallpaper}" \
    --scheme "${scheme}" --mode "${mode}" --transparency "${transparency}" > "${cache_dir}/material-colors.scss"

"${HOME}/.config/hypr/scripts/color_generation/apply_colors.sh"
python "${HOME}/.local/bin/hypr_config_gen.py"

if [ "${darkmode}" = "true" ]; then
	sed -i "s/black/white/g" "${waybar_config}"
else
	sed -i "s/white/black/g" "${waybar_config}"
fi

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

pywalfox update
#swaync-client -rs
