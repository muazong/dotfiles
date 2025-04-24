#!/bin/bash

process_weather() {
  echo "$1" | tr -d '\r\n' | sed 's/[[:space:]]*$//'
}

if ping -c 3 -W 1 8.8.8.8 &>/dev/null; then
  location="Sontay"
  lat="21.13"
  lon="105.50"

  weather_raw=$(curl -s --max-time 2 "wttr.in/$location?format=%t+%c")

  if [[ -z "$weather_raw" || "$weather_raw" == *"Unknown"* ]]; then
    weather_raw=$(curl -s --max-time 3 "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code&timezone=Asia/Ho_Chi_Minh")

    if [[ -n "$weather_raw" ]]; then
      temperature=$(echo "$weather_raw" | jq -r '.current.temperature_2m')
      weather_code=$(echo "$weather_raw" | jq -r '.current.weather_code')

      case $weather_code in
      0) weather_icon="󰖙" ;;                      # Clear sky
      1 | 2 | 3) weather_icon="󰖕" ;;              # Partly cloudy
      45 | 48) weather_icon="󰖑" ;;                # Fog
      51 | 53 | 55 | 56 | 57) weather_icon="󰖗" ;; # Drizzle
      61 | 63 | 65 | 66 | 67) weather_icon="󰖖" ;; # Rain
      71 | 73 | 75 | 77) weather_icon="󰖘" ;;      # Snow
      80 | 81 | 82) weather_icon="󰖖" ;;           # Heavy rain showers
      85 | 86) weather_icon="󰼱" ;;                # Snow showers
      95 | 96 | 99) weather_icon="󰼳" ;;           # Thunderstorm
      *) weather_icon="󰅘" ;;                      # Unknown
      esac

      printf "%s, %s°C %s\n" "$location" "$temperature" "$weather_icon"
    else
      echo "󰅘 No Information"
    fi
  else
    weather=$(process_weather "$weather_raw")
    printf "%s, %s\n" "$location" "$weather" | tr -d '+'
  fi
else
  echo "󰖪 No Internet"
fi
