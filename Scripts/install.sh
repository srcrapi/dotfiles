#!/usr/bin/env bash

src_dir=$(dirname "$(realpath "$0")")
dots_dir="${src_dir}/.."
system_bkp="${HOME}/old-system-bkp"
config_dir="${HOME}/.config"
username=`whoami`
generate_material_colors="${HOME}/.config/hypr/scripts/color_generation/generate_material_colors.py"
source "${src_dir}/global_funcs.sh"

if [ "$?" -ne 0 ]; then
	echo ":: Error: Couldn't source global_funcs.sh"
	exit 1
fi

install_yay() {
	if is_package_exists yay ; then
		return 0
	fi

	git clone https://aur.archlinux.org/yay.git /tmp/yay

	cd /tmp/yay

	makepkg -si || { echo ":: Error: Failed to build yay"; exit 1; }
	rm -rf /tmp/yay
}

install_pkgs() {
	local pkgs=("$@")
	local set_pkgs=()

	for pkg in "${pkgs[@]}"; do
		if ! is_package_exists "$pkg" ; then
			set_pkgs+=("$pkg")
		fi
	done

	yay -S "${set_pkgs[@]}"
}

install_pywal_discord() {
	while true; do
		read -p ":: Do you want to install pywal for discord (yes/no)? " pywal_dc_op

		case "$pywal_dc_op" in
			yes|y)
				echo ":: Installing Pywal Discord"
				git clone "https://github.com/quantumwavves/pywal-discord-vencord.git" "$HOME/pywal-discord-vencord"
				chmod +x "$HOME/pywal-discord-vencord/setup"
				"$HOME/pywal-discord-vencord/setup"
				echo ":: Installed"
				;;
			no|n)
				break
				;;
			*)
				echo ":: Please use only yes/y or no/n"
				;;
		esac
	done
}


install_yay

pkgs=( $( grep -v "^#" "${src_dir}/pkgs.lst" ) ) 


if [ ! -d "/usr/share/pywal-discord" ]; then
	install_pywal_discord
fi

if [ ! -d "${HOME}/.tmux/plugins" ]; then
	echo ":: Installing Tmux plugin Manager"
	git clone "https://github.com/tmux-plugins/tpm" ~/.tmux/plugins/tpm &> /dev/null 
	echo ":: Installed"
fi

setup_sddm
setup_grub

mkdir -p "${system_bkp}" "${HOME}/Downloads" "${HOME}/Pictures" "${HOME}/Videos" "${HOME}/Documents" "${HOME}/Music"
mkdir -p "${HOME}/.local/bin"

mv -n "${config_dir}" "${system_bkp}"
cp -r "${dots_dir}/.config" "${config_dir}"

cp -r "${dots_dir}/shell" "${HOME}"
cp "${dots_dir}/.zsh*" "${HOME}"
cp -r "${dots_dir}/.local/bin" "${HOME}/.local/bin"

if [ "rap1" != "$username" ]; then
	mv "${config_dir}/nvim/lua/rap1" "${config_dir}/nvim/lua/${username}"
	find "${config_dir}/nvim/lua/${username}" -name "*.lua" -exec sed -i "s/rap1/${username}/g" {} + 
fi

# setup wallpapers

echo ":: Getting wallpapers..."
git clone "https://github.com/srcrapi/wallpaper.git" "${HOME}/Pictures/wallpapers" &> /dev/null
mv "${HOME}"/Pictures/wallpapers/**/* "${HOME}/Pictures/wallpapers"
find "${HOME}/Pictures/wallpapers" -mindepth 1 -type d -exec rm -rf {} +
rm "${HOME}/Pictures/wallpapers/README.md"
echo ":: Finished setting up wallpapers"

# create ryarch file

if [ ! -f "${config_dir}/ryarch.json" ]; then
	echo "{}" > "${config_dir}/ryarch.json"
fi

"${HOME}/.local/bin/hypr_config_gen.sh"

python "${generate_material_colors}" --path "${HOME}/Pictures/wallpapers/kessoku_band_sunset.jpg" \
	> "${cache_dir}/material-colors.scss"
