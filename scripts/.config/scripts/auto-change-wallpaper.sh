#!/bin/bash

WALLPAPERS=($(ls -1 ~/Pictures/wallpapers/*))
INDEX=0

while true; do
  hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$INDEX]}"
  INDEX=$(((INDEX + 1) % ${#WALLPAPERS[@]}))

  sleep 300 # 5 minutes
done
