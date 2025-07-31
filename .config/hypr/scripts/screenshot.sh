#!/usr/bin/env bash

saveDir="${HOME}/Pictures/Screenshot"
saveFile="$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')"
swpyDir="${HOME}/.config/swappy"
temp_screenshot="/tmp/screenshot.png"

mkdir -p $saveDir
mkdir -p $swpyDir

echo -e "[Default]\nsave_dir=$saveDir\nsave_filename_format=$saveFile" > $swpyDir/config

case $1 in
	p) # print all outputs
		grimblast copysave screen $temp_screenshot && swappy -f $temp_screenshot ;;
	s) # drag to manually snip an area / click on a window to print it
		grimblast copysave area $temp_screenshot && swappy -f $temp_screenshot ;;
	m) # print focused monitor
		grimblast copysave output $temp_screenshot && swappy -f $temp_screenshot ;;
	*) # invalid option
		notify-send "Screenshot failed"
		exit
		;;
esac

rm "$temp_screenshot"

if [ -f "${saveDir}/${saveFile}" ]; then
	notify-send -a "t1" -i "${saveDir}/${saveFile}" "saved in ${saveDir}"
fi
