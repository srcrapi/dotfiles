#!/usr/bin/env sh

save_dir="$HOME/.config/swww"
srcDir="$(dirname "$0")"
cache_dir="${save_dir}/.cache"
config_dir="${HOME}/.config"
prompt_location="${config_dir}/starship"
waybar_dir="$config_dir/waybar"
conf_ctl="$waybar_dir/config.ctl"
styles_dir="$waybar_dir/styles"
themes_dir="$config_dir/hypr/themes"

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
	bar_name="$(grep 'Name' $conf_ctl | cut -d '=' -f 2 | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)"

	if [ -z "$bar_name" ]; then
		exit 1
	fi

	bar_name_index=$(grep -n "Name=$bar_name$" $conf_ctl | cut -d ':' -f 1)

	# pega a linha da config da barra
	bar_conf_index=$((bar_name_index + 1))
	echo "$bar_conf_index"

	bar_conf=$(cat "$conf_ctl" | sed -n "${bar_conf_index}p")

	first_item=$(echo "$bar_conf" | cut -d "|" -f 1)
	
	# se a barra atual for selecionada sai
	if [[ $first_item == "1" ]]; then
		exit 0
	fi

	# remove a barra atual que esta ativa
	sed -i "s/^1|/0|/g" "$conf_ctl"

	# muda a barra selecionada para atual
	sed -i "${bar_conf_index}s/^0|/1|/g" "$conf_ctl"
}

select_bar_style() {
	style_name=$(ls ${styles_dir} | cut -d "." -f 1 | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)

	ln -fs "${styles_dir}/${style_name}.css" "${waybar_dir}/modules/style.css"
}

case "$1" in
	-wall | --wallpaper)
		# List all the wallpapers
		"${srcDir}/color_generation/config_generate.sh"
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
