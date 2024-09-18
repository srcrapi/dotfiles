#!/usr/bin/env bash

src_dir=$(dirname "$(realpath "$0")")
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
				git clone "https://github.com/quantumwavves/pywal-discord-vencord.git" "$HOME"
				chmod +x "$HOME/pywal-discord-vencord/setup"
				"$HOME/pywal-discord-vencord/setup"
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

