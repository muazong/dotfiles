#!/bin/bash

WALLPAPERS=($(ls -1 ~/Pictures/wallpapers/4k/*))
INDEX=0

while true; do
  hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$INDEX]}"
  INDEX=$(((INDEX + 1) % ${#WALLPAPERS[@]}))

  sleep 420 # 7min
done
