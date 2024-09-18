#!/usr/bin/env sh

updates=$(checkupdates | wc -l)

if [ ${updates} -ne 0 ]; then
  echo "{\"text\": \"${updates}\", \"tooltip\": \"Update: ${updates}\"}"
else 
  echo "{\"text\": \"${updates}\", \"tooltip\": \"No updates available\"}"
fi
