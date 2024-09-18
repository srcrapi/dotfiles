#!/usr/bin/env bash

set -e

is_package_exists() {
	local pkg="$1"

	if pacman -Qi "$pkg" &> /dev/null ; then
		return 0
	fi

	return 1
}
