#!/bin/bash

PREV_STATUS=""
FULL_NOTIFIED=0
PREV_CAPACITY=-1
BATTERY_STATUS_PATH="/sys/class/power_supply/BAT0/status"
BATTERY_CAPACITY_PATH="/sys/class/power_supply/BAT0/capacity"

while true; do
  STATUS=$(<"$BATTERY_STATUS_PATH")
  CAPACITY=$(<"$BATTERY_CAPACITY_PATH")

  if [ "$STATUS" != "$PREV_STATUS" ] || ([ "$CAPACITY" -eq 100 ] && [ "$FULL_NOTIFIED" -eq 0 ]); then
    MESSAGE=""
    case "$STATUS" in
    "Charging")
      if [ "$CAPACITY" -eq 100 ] && [ "$FULL_NOTIFIED" -eq 0 ]; then
        MESSAGE="🔋 Battery Full: Please unplug the charger."
        FULL_NOTIFIED=1
      elif [ "$PREV_STATUS" != "Charging" ]; then
        MESSAGE="🔋 Charging: The device is currently charging."
      fi
      ;;
    "Discharging")
      if [ "$PREV_STATUS" != "Discharging" ]; then
        MESSAGE="⚡ Not Connected: The charger is not plugged in."
      fi
      FULL_NOTIFIED=0
      ;;
    esac

    if [ -n "$MESSAGE" ]; then
      notify-send -u normal -t 3000 "$MESSAGE"
    fi
    PREV_STATUS="$STATUS"
  fi

  if [ "$CAPACITY" -lt 100 ]; then
    FULL_NOTIFIED=0
  fi

  PREV_CAPACITY="$CAPACITY"

  sleep 1
done
