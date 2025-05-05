#!/usr/bin/env sh

save_dir="$HOME/.config/swww"
srcDir="$(dirname "$0")"
cache_dir="${save_dir}/.cache"
config_dir="${HOME}/.config"
prompt_location="${config_dir}/starship"
waybar_dir="$config_dir/waybar"
ryarch="${config_dir}/ryarch/ryarch.json"
styles_dir="$waybar_dir/styles"
themes_dir="$config_dir/hypr/themes"
local_bin="${HOME}/.local/bin"

help_menu() {
	echo "$0" commands:
	echo
	echo -h, --help : Shows the help menu
	echo -w, --wallpaper : Sets wallpaper and the pywal
	echo -c, --clear : Clears the cache directory
}

clear_cache() {
	if [ ! -d "${cache_dir}" ]; then
	echo "Directory don't to be cleared"
	exit 1
	fi

	rm -rf "${cache_dir:?}"/*
}

select_prompt() {
    prompt_style="$(ls "${prompt_location}" | sed "s/\.toml$//" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)"

    if [ ! -z "${prompt_style}" ]; then
        ln -fs "${prompt_location}/${prompt_style}.toml" "${config_dir}/starship.toml" 
    fi
}

select_bar() {
	bar_name="$(jq -r ".waybar.bars[].name" "$ryarch" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)"

	[[ -z "$bar_name" ]] && exit 1

	is_active=$(jq -r --arg name "$bar_name" '.waybar.bars[] | select(.name == $name) | .active' "$ryarch")

	[[ "$is_active" == "1" ]] && exit 0

	jq --arg name "$bar_name" '
		.waybar.bars |= map(
			if .name == $name then .active = 1 else .active = 0 end
		)
	' "$ryarch" > "${ryarch}.tmp" && mv "${ryarch}.tmp" "$ryarch"

	style_name=$(jq -r --arg name "$bar_name" '.waybar.bars[] | select(.name == $name) | .style' "$ryarch")

	echo "$style_name"

	"${local_bin}/bar_confgen.sh"	
	select_bar_style "$style_name"

}

select_bar_style() {
	if [ -z "$1" ]; then
		style_name=$(ls ${styles_dir} | cut -d "." -f 1 | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)

		if [ -z "$style_name" ]; then
			exit 1
		fi
	else
		style_name="$1"
	fi

	bar_name=$(jq -r ".waybar.bars[] | select(.active == 1) | .name" "$ryarch")
	
	jq --arg name "$bar_name" --arg style "$style_name" '
		.waybar.bars |= map(
			if .name == $name then .style = $style else . end
		)
	' "$ryarch" > "${ryarch}.tmp" && mv "${ryarch}.tmp" "$ryarch"

	ln -fs "${styles_dir}/${style_name}.css" "${waybar_dir}/modules/style.css"
	"${local_bin}/bar_stylegen.sh"	

	pkill waybar && sleep 0.5 && waybar &
}

case "$1" in
	-wall | --wallpaper)
		# List all the wallpapers
		~/.config/hypr/scripts/color_generation/config_generate.sh
		;;
	-b | --bar)
		select_bar
		;;
	-bs | --bar-style)
		select_bar_style
		;;
    -p | --prompt)
        # Select prompt style
        select_prompt
        ;;
    -c | --clear)
        # Clear cache directory
        clear_cache
        ;;
	-d | --drun)
		rofi -show drun
		;;
	-w | --window)
		rofi -show window
		;;
	-f | --file-browser)
		rofi -show filebrowser
		;;
	-h | --help)
		help_menu
		;;
	*)
		help_menu
		;;
esac
