#!/bin/bash

mapfile -t WALLPAPERS < <(find ~/Pictures/wallpapers/WLOP/ -type f)

INDEX=0

while true; do
  hyprctl hyprpaper preload "${WALLPAPERS[$INDEX]}"
  hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$INDEX]}"
  INDEX=$(((INDEX + 1) % ${#WALLPAPERS[@]}))

  sleep 420 # 7min
done
