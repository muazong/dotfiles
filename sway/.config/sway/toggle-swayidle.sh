#!/bin/bash
if pgrep -x swayidle >/dev/null; then
  pkill -x swayidle
  notify-send -u normal -i "system-lock-screen" "Swayidle" "● Đã tắt idle guard" -t 3000
else
  swayidle -w \
    timeout 300 'swaylock -f --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color 10b981 --key-hl-color facc15 --inside-color 1f2937 --separator-color 000000ff --text-color ffffff --line-color 00000000 --inside-ver-color 3b82f6 --ring-ver-color 3b82f6' \
    timeout 420 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
    timeout 480 'systemctl suspend' \
    before-sleep 'swaylock -f --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color 10b981 --key-hl-color facc15 --inside-color 1f2937 --separator-color 000000ff --text-color ffffff --line-color 00000000 --inside-ver-color 3b82f6 --ring-ver-color 3b82f6' &
  notify-send -u low -i "system-lock-screen" "Swayidle" "● Đã bật idle guard" -t 3000
fi
