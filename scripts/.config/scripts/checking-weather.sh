#!/bin/bash

if ping -c 1 -W 1 8.8.8.8 &>/dev/null; then
  location="Sơn Tây"
  lat="21.13"
  lon="105.50"

  weather_raw=$(curl -s --max-time 3 "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code&timezone=Asia/Ho_Chi_Minh")

  if [[ -n "$weather_raw" ]]; then
    temperature=$(echo "$weather_raw" | jq -r '.current.temperature_2m')
    weather_code=$(echo "$weather_raw" | jq -r '.current.weather_code')

    case $weather_code in
    0)
      weather_icon="󰖙"
      weather_desc="Trời quang"
      ;;
    1)
      weather_icon="󰖙"
      weather_desc="Nắng nhẹ"
      ;;
    2)
      weather_icon="󰖕"
      weather_desc="Có mây"
      ;;
    3)
      weather_icon="󰖐"
      weather_desc="Nhiều mây"
      ;;
    45 | 48)
      weather_icon="󰖑"
      weather_desc="Sương mù"
      ;;
    51 | 53 | 55)
      weather_icon="󰖗"
      weather_desc="Mưa phùn"
      ;;
    61 | 63)
      weather_icon="󰖖"
      weather_desc="Mưa vừa"
      ;;
    65 | 66 | 67)
      weather_icon="󰖖"
      weather_desc="Mưa to"
      ;;
    71 | 73 | 75 | 77)
      weather_icon="󰖘"
      weather_desc="Có tuyết"
      ;;
    80 | 81 | 82)
      weather_icon="󰖖"
      weather_desc="Mưa rào"
      ;;
    95)
      weather_icon="󰼳"
      weather_desc="Dông bão"
      ;;
    96 | 99)
      weather_icon="󰼳"
      weather_desc="Dông kèm mưa đá"
      ;;
    *)
      weather_icon="󰅘"
      weather_desc="N/A"
      ;;
    esac

    printf "%s, %s°C %s  %s\n" "$location" "$temperature" "$weather_icon" "$weather_desc"
  else
    echo "󰅘 Lỗi dữ liệu"
  fi
else
  echo "󰖪 Mất mạng"
fi
