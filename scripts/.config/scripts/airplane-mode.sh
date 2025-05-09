#!/bin/bash

check_status() {
  rfkill list | grep -q "Soft blocked: yes"
}

status() {
  if check_status; then
    echo "󰀝 on" # Airplane (on)
  else
    echo " off" # Airplane (off)
  fi
}

toggle() {
  if check_status; then
    rfkill unblock all
    notify-send "✈️ Airplane Mode Off"
  else
    rfkill block all
    notify-send "✈️ Airplane Mode On"
  fi
}

case "$1" in
status)
  status
  ;;
toggle)
  toggle
  ;;
*)
  echo "Usage: $0 {status|toggle}"
  ;;
esac
