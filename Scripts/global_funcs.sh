#!/usr/bin/env bash

set -e

src_dir=$(dirname "$(realpath  "$0")")

is_package_exists() {
	local pkg="$1"

	if pacman -Qi "$pkg" &> /dev/null ; then
		return 0
	fi

	return 1
}

setup_sddm() {
	echo ":: Configuring SDDM theme"
	sudo cp -r "${src_dir}/../themes" /usr/share/sddm
	sudo cp -r "${src_dir}/../faces" /usr/share/sddm
	sudo cp -r "${src_dir}/../sddm.conf.d" /etc/
	echo ":: Complete"
}

setup_grub() {
	echo ":: Configuring Grub theme"
	sudo cp -r "${src_dir}/../grub-theme/ryo" /usr/share/grub/themes
	sudo sed -i "s+^GRUB_THEME=.*+GRUB_THEME=\"/usr/share/grub/themes/ryo/theme.txt\"+g" /etc/default/grub
	echo ":: Complete"
}
