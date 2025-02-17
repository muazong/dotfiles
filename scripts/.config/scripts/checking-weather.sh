#!/bin/bash

process_weather() {
  echo "$1" | tr -d '\r\n' | sed 's/[[:space:]]*$//'
}

if ping -c 3 -W 1 8.8.8.8 &>/dev/null; then
  location="Sontay"
  weather_raw=$(curl -s "wttr.in/$location?format=%t+%c")

  if [[ -n "$weather_raw" ]]; then
    weather=$(process_weather "$weather_raw")
    printf "%s, %s\n" "$location" "$weather" | tr -d '+'
  else
    echo "No Information."
  fi
else
  echo "No Internet."
fi
