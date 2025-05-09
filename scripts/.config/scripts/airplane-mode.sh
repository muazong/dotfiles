#!/bin/bash

check_status() {
  total=$(rfkill list | grep -c "Soft blocked")
  blocked=$(rfkill list | grep "Soft blocked: yes" | wc -l)
  [[ "$total" -gt 0 && "$blocked" -eq "$total" ]]
}

status() {
  if check_status; then
    echo "󰀝 on"
  else
    echo " off"
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
