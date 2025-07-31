#!/usr/bin/env sh

src_dir="${HOME}/.config/hypr/scripts"
cache_dir="${HOME}/.cache/material-colors"
config_dir="${HOME}/.config"
templates_dir="${src_dir}/color_generation/templates"
dotfiles="${HOME}/.local/share/dotfiles"

color_names=$(cat "${cache_dir}/material-colors.scss" | cut -d ":" -f1)
color_values=$(cat "${cache_dir}/material-colors.scss" | cut -d ":" -f2 | cut -d " " -f2 | cut -d ";" -f1)

IFS=$'\n'
color_names_list=( $color_names )
color_values_list=( $color_values )


apply() {
	filename="$1"
	conf_dir="$2"
	filename_dir="$3"
	colorscheme=`jq -r ".neovim_colorscheme" "${cache_dir}/config.json"`

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
		else
			sed -i "s/{{ ${color_names_list[$i]} }}/${color_values_list[$i]}/g" "${cache_dir}/${filename}"
		fi

	done
	
	if [ "$filename" = "colorscheme.lua" ]; then
		sed -i "s/{{ colorscheme }}/${colorscheme}/g" "${cache_dir}/${filename}"
	fi

	cp "${cache_dir}/${filename}" "${conf_dir}"
}


apply_kitty() {
	apply "colors-kitty.conf" "${config_dir}"/kitty
	pkill -10 kitty
}

apply_ghostty() {
	apply "colors-ghostty" "${config_dir}"/ghostty
}

apply_wezterm() {
	apply "colors-wezterm.lua" "${config_dir}"/wezterm
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

apply_nvim() {
	apply "colorscheme.lua" "${config_dir}/nvim/lua/${USER}/core" "nvim"
}

apply_dunst() {
	apply "dunstrc" "${config_dir}/dunst"
	systemctl --user restart dunst
}

apply_rmpc() {
	apply "ryarch.ron" "${dotfiles}/.config/rmpc/themes"
}

apply_foot() {
	apply "colors-foot.ini" "${dotfiles}/.config/foot/"
}

apply_discord() {
	apply "rycord.sistem24.css" "${dotfiles}/.config/Vencord/themes/" "Rycord"
}

apply_waybar &
apply_hyprland &
apply_rofi &
#apply_spicetify_theme &
apply_cava &
apply_nvim &
apply_dunst &
apply_rmpc &

#apply_foot &
apply_kitty &
apply_ghostty &
apply_wezterm &
apply_discord &
