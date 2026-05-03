#!/bin/bash

wallpapers=()
while IFS= read -r -d '' file; do
  wallpapers+=("$file")
done < <(find ~/Pictures/Wallpapers/ -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" \) -print0)

if [ ${#wallpapers[@]} -eq 0 ]; then
  notify-send "Not found any wallpapers"
  exit 1
fi

trap 'killall swaybg 2>/dev/null; exit' INT TERM

index=0

while true; do
  selected="${wallpapers[$index]}"
  swaybg -i "$selected" -m fill
  index=$((index + 1))
  if [ $index -ge ${#wallpapers[@]} ]; then
    index=0
  fi

  sleep 300
done
