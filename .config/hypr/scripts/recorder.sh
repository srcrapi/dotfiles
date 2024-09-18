#!/usr/bin/env sh

saveDir="${HOME}/Videos"
saveFile="$(date +'%d-%m-%y_%Hh%Mm%Ss_record.mp4')"
icons="${HOME}/.config/hypr/scripts/icons"
tempFile="/tmp/recording.flag"
tempThumbnail="/tmp/thumbnail.png"
programName=$(basename "$0")


helpMenu() {
  echo "${programName}" commands:
  echo
  echo -s, --start : Starts recording the screen with audio
  echo -sn, --start-no-audio : Starts recording the screen without audio
  echo --stop : Stops the recording
}

startRecording() {
  if [ -f "${tempFile}" ]; then
    notify-send -t 2500 "The program is already running" -a "recorder.sh"
    exit 1
  fi

  monitors=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
  monitorCount=$(echo "${monitors}" | wc -w)

  if [ "${monitorCount}" -eq 1 ]; then
    selectedMonitor="${monitors}"
  else
    selectedMonitor=$(echo ${monitors} | tr ' ' '\n' | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry- MousePrimary)

    if [ -z "${selectedMonitor}" ]; then
      notify-send -t 2500 "Please select a monitor" -a "recorder.sh"
      exit 1
    fi
  fi

  sendNotification 
  echo "${saveDir}/${saveFile}" > "${tempFile}"

  if [ "$1" = "audio" ]; then
	if [ "$2" = "desktop" ];then
		wf-recorder --output "${selectedMonitor}" --pixel-format yuv420p --framerate 60 -f "${saveDir}/${saveFile}" --audio="alsa_output.pci-0000_03_00.6.HiFi__Headphones__sink.3.monitor"
	else
		wf-recorder --output "${selectedMonitor}" --pixel-format yuv420p --framerate 60 -f "${saveDir}/${saveFile}" --audio="alsa_input.pci-0000_03_00.6.HiFi__Mic2__source.3"
	fi
  else
    wf-recorder --output "${selectedMonitor}" --pixel-format yuv420p --framerate 60 -f "${saveDir}/${saveFile}"
  fi
}

sendNotification() {
  if [ "$1" = "stop" ]; then
    saveFile=$(cat "${tempFile}")

    ffmpeg -i "${saveFile}" -ss 00:00:01 -vframes 1 "${tempThumbnail}"
    notify-send -t 2500 -a "t1" -i "${tempThumbnail}" "Video saved in ${saveDir}/" -a "recorder.sh"

    rm "${tempThumbnail}"
    rm "${tempFile}"

    exit 0
  fi

  notify-send -t 2500 -a "t1" -i "${icons}/record.svg" "Starting recording" "recording ${saveFile}" -a "recorder.sh"
}


case "$1" in
  -sd | --start-recording-desktop-audio)
    startRecording "audio" "desktop"
    ;;
  -sm | --start-recording-microphone-audio)
    startRecording "audio" "micro"
    ;;
  -sn | --start-no-audio)
    startRecording
    ;;
  --stop)
    if [ ! -f  "${tempFile}" ]; then
      notify-send -t 2500 "No recording is currently running" -a "recorder.sh"
      exit 1
    fi

    pkill -x wf-recorder
    sendNotification "stop"
    ;;
  *)
    helpMenu
esac
