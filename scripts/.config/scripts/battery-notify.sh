#!/bin/bash

PREV_STATUS=""
BATTERY_PATH="/sys/class/power_supply/BAT0/status"

while true; do
  STATUS=$(<"$BATTERY_PATH")
  if [ "$STATUS" != "$PREV_STATUS" ]; then
    MESSAGE=""
    case "$STATUS" in
    "Charging")
      MESSAGE="🔋 Charging: The device is currently charging."
      ;;
    "Discharging")
      MESSAGE="⚡ Not Connected: The charger is not plugged in."
      ;;
    esac
    if [ -n "$MESSAGE" ]; then
      notify-send -u normal -t 3000 "$MESSAGE"
    fi
    PREV_STATUS="$STATUS"
  fi
  sleep 0.1
done
