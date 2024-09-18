#!/usr/bin/env sh

src_dir="${HOME}/.config/hypr/scripts"
cache_dir="${HOME}/.cache/material-colors"
config_dir="${HOME}/.config"
templates_dir="${src_dir}/color_generation/templates"

color_names=$(cat "${cache_dir}/material-colors.scss" | cut -d ":" -f1)
color_values=$(cat "${cache_dir}/material-colors.scss" | cut -d ":" -f2 | cut -d " " -f2 | cut -d ";" -f1)

IFS=$'\n'
color_names_list=( $color_names )
color_values_list=( $color_values )


apply() {
	filename="$1"
	conf_dir="$2"
	filename_dir="$3"

	if [ -z "$filename_dir" ]; then
		cp "${templates_dir}/${filename}" "${cache_dir}/${filename}"
	else
		mkdir -p "${cache_dir}/${filename_dir}"
		cache_dir="${cache_dir}/${filename_dir}"
		cp "${templates_dir}/${filename_dir}/${filename}" "${cache_dir}/${filename}"
	fi

	for i in "${!color_names_list[@]}"; do
		if [[ "$filename" == *"hypr"* ]] || [[ "$filename" = "color.ini" ]]; then
			sed -i "s/{{ ${color_names_list[$i]} }}/${color_values_list[$i]#\#}/g" "${cache_dir}/${filename}"
		fi

		sed -i "s/{{ ${color_names_list[$i]} }}/${color_values_list[$i]}/g" "${cache_dir}/${filename}"
	done

	cp "${cache_dir}/${filename}" "${conf_dir}"
}


apply_kitty() {
	apply "colors-kitty.conf" "${config_dir}"/kitty
	pkill -10 kitty
}


apply_waybar() {
	apply "colors-waybar.css" "${config_dir}"/waybar
}

apply_hyprland() {
	apply "colors-hyprland.conf" "${config_dir}"/hypr/hyprland
	apply "hyprlock.conf" "${config_dir}/hypr" "hypr"
}

apply_rofi() {
	apply "colors-rofi.rasi" "${config_dir}"/rofi
}

apply_spicetify_theme() {
	apply "color.ini" "${config_dir}/spicetify/Themes/Sleek" "spicetify/sleek"
}

apply_cava() {
	apply "config" "${config_dir}/cava" "cava"
}


apply_kitty &
apply_waybar &
apply_hyprland &
apply_rofi &
apply_spicetify_theme &
apply_cava &
