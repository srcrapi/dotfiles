#!/usr/bin/env bash

hypr_dir="${HOME}/.config/hypr"
templates_dir="${hypr_dir}/templates"
global_config="${HOME}/.config/ryarch.json"
hypr_conf_temp="${templates_dir}/hyprland.conf"
cache_dir="${templates_dir}/.cache"


if [ ! -d "$templates_dir" ]; then
	mkdir "$templates_dir"
fi

if [ ! -d "$cache_dir" ]; then
	mkdir "$cache_dir"
fi

cp "${hypr_conf_temp}" "${cache_dir}"

hypr_json=`jq -r ".hyprland" "$global_config"`

if [ -z "$hypr_json" ] || [ "$hypr_json" = "null" ]; then
	while true; do
		read -p "Do you want rounded corners? (yes/no) " rounded_corners

		if [ "$rounded_corners" = "yes" ] || [ "$rounded_corners" = "no" ]; then
			[ "$rounded_corners" = "yes" ] && rounded_corners=true || rounded_corners=false
			break
		else
			echo "Please use only yes or no"
		fi
	done

	while true; do
		read -p "What border size do you want (0 means none): " border_size 
		
		if ! echo "$border_size" | grep -q "^[0-9]*$" ; then
			echo "You only can use numbers"
			continue
		fi

		break
	done

	while true; do
		read -p "Do you want shadows? (yes/no) " shadow

		if [ "$shadow" = "yes" ] || [ "$shadow" = "no" ]; then
			[ "$shadow" = "yes" ] && shadow=true || shadow=false
			break
		fi

		echo "Please use only yes or no"
	done

	while true; do
		read -p "Do you want to add more keyboard layouts (default: us)? (yes/no) " key_layouts

		if [ "$key_layouts" = "yes" ]; then
			read -p "Add custom layouts: " custom_layout
		else
			custom_layout=""
		fi

		custom_layout=`echo "$custom_layout" | sed 's/ /","/g' | sed 's/^/"/;s/$/"/'`
		break
	done

	if [ -n "$custom_layout" ]; then
		keyboard_layouts="[\"us\",$custom_layout]"
	else
		keyboard_layouts="[\"us\"]"
	fi


	jq --arg key_layout "$keyboard_layouts" --arg corners "$rounded_corners" --arg shadow "$shadow" --arg border_size "$border_size" \
		'. + { "hyprland": { "rounded_corners": $corners, "border_size": $border_size, "shadow": $shadow, "keyboard_layouts": ($key_layout | fromjson) } }' \
		"$global_config" > /tmp/ryarch-tmp.json
	mv /tmp/ryarch-tmp.json "$global_config"
fi

b_radius=`jq -r ".hyprland.rounded_corners" "$global_config"`
b_size=`jq -r ".hyprland.border_size" "$global_config"`
d_shadow=`jq -r ".hyprland.shadow" "$global_config"`
k_layouts=`jq -r '.hyprland.keyboard_layouts | join(",")' "$global_config"`

if [ "$b_radius" = "true" ]; then
	b_radius=20
else
	b_radius=0
fi

declare -A values=(
	["b_radius"]=$b_radius
	["d_shadow"]=$d_shadow
	["k_layouts"]=$k_layouts
	["b_size"]=$b_size
)

for key in "${!values[@]}"; do
	sed -i "s/{{ $key }}/${values[$key]}/g" "${cache_dir}/hyprland.conf"
done

cp "${cache_dir}/hyprland.conf" "${hypr_dir}/hyprland.conf"
