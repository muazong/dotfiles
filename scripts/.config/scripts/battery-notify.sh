#!/bin/bash

BATTERY_STATUS_PATH="/sys/class/power_supply/BAT0/status"
BATTERY_CAPACITY_PATH="/sys/class/power_supply/BAT0/capacity"
PREV_STATUS=""
FULL_NOTIFIED=0
LOW_BATTERY_NOTIFIED=0

while true; do
  read -r STATUS <"$BATTERY_STATUS_PATH"
  read -r CAPACITY <"$BATTERY_CAPACITY_PATH"

  if [[ "$STATUS" != "$PREV_STATUS" || ("$CAPACITY" -eq 100 && FULL_NOTIFIED -eq 0) ]]; then
    case "$STATUS" in
    "Charging")
      if [[ "$CAPACITY" -eq 100 && FULL_NOTIFIED -eq 0 ]]; then
        notify-send -t 3000 "🔋 Unplug charger."
        paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
        FULL_NOTIFIED=1
      elif [[ "$PREV_STATUS" != "Charging" ]]; then
        notify-send -t 3000 "⚡ Charging..."
        paplay /usr/share/sounds/freedesktop/stereo/power-plug.oga
      fi
      LOW_BATTERY_NOTIFIED=0
      ;;
    "Discharging")
      if [[ "$PREV_STATUS" != "Discharging" ]]; then
        notify-send -t 3000 "🔌 Not charging."
        paplay /usr/share/sounds/freedesktop/stereo/power-unplug.oga
      fi
      FULL_NOTIFIED=0
      ;;
    esac
    PREV_STATUS="$STATUS"
  fi

  if [[ "$CAPACITY" -lt 30 && "$STATUS" == "Discharging" && LOW_BATTERY_NOTIFIED -eq 0 ]]; then
    notify-send -t 3000 "⚠️ Low battery!"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    LOW_BATTERY_NOTIFIED=1
  elif [[ "$CAPACITY" -ge 30 ]]; then
    LOW_BATTERY_NOTIFIED=0
  fi

  ((CAPACITY < 100)) && FULL_NOTIFIED=0

  sleep 1
done
