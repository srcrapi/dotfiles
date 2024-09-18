#!/usr/bin/env sh

config_dir="${HOME}/.config"
waybar_dir="${config_dir}/waybar"
config_file="${waybar_dir}/config.jsonc"
config_ctl="${waybar_dir}/config.ctl"
modules_dir="${waybar_dir}/modules"

export w_position=`grep '^1|' $config_ctl | cut -d '|' -f 6`
export m_top=`grep '^1|' $config_ctl | cut -d '|' -f 2`
export m_bot=`grep '^1|' $config_ctl | cut -d '|' -f 3`
export m_left=`grep '^1|' $config_ctl | cut -d '|' -f 4`
export m_right=`grep '^1|' $config_ctl | cut -d '|' -f 5`

if [ -z "$m_top" ]; then
	m_top=0
fi

if [ -z "$m_bot" ]; then
	m_bot=0
fi

if [ -z "$m_left" ]; then
	m_left=0
fi

if [ -z "$m_right" ]; then
	m_right=0
fi

envsubst < "$modules_dir/header.jsonc" > "$config_file"

gen_modules() {
	local position="$1"
	local col="$2"
	local module=""
	
	module=`grep '^1|' $config_ctl | cut -d '|' -f ${col} | sed -e 's/{//g' -e 's/}//g'`
	module="${module//(/""}"
	module="${module//)/""}"
	module="${module//::/"custom/padd"}"
	module="${module//@/"custom/sep"}"
	module="${module// /"\",\""}"

	echo -e "\t\"modules-${position}\": [\"${module}\"]," >> $config_file
}

echo -e "\n\n\t// source based on config.ctl //\n" >> $config_file
gen_modules left 7
gen_modules center 8
gen_modules right 9

modules=`grep "^1|" $config_ctl | awk -F "[{}]" '{print $2}'`
modules_names=$(echo "$modules" | grep -oP '[a-zA-Z0-9/_]+')
modules_array=($modules_names)

echo -e "\n\n\t// source in the modules folder  //\n" >> $config_file

for mod in "${modules_array[@]}"; do
	if [[ "$mod" == *"custom/"* ]]; then
		clean_mod=$(echo "$mod" | sed "s|custom/||g")
	else
		clean_mod=$(echo "$mod" | sed "s|hyprland/||g")
	fi

	cat "$modules_dir/$clean_mod.jsonc" >> "$config_file"
done

cat "$modules_dir/footer.jsonc" >> "$config_file"
