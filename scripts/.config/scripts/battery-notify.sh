#!/bin/bash

PREV_STATUS=""
BATTERY_STATUS_PATH="/sys/class/power_supply/BAT0/status"
BATTERY_CAPACITY_PATH="/sys/class/power_supply/BAT0/capacity"

while true; do
  STATUS=$(<"$BATTERY_STATUS_PATH")
  CAPACITY=$(<"$BATTERY_CAPACITY_PATH")

  if [ "$STATUS" != "$PREV_STATUS" ] || [ "$CAPACITY" -eq 100 ]; then
    MESSAGE=""
    case "$STATUS" in
    "Charging")
      if [ "$CAPACITY" -eq 100 ]; then
        MESSAGE="🔋 Battery Full: Please unplug the charger."
      else
        MESSAGE="🔋 Charging: The device is currently charging."
      fi
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
  sleep 1
done
