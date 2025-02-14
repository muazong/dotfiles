#!/bin/bash
# The most sincere thanks to Gemini - Google :D

# Function to fetch and display weather information
get_weather() {
  city=Sontay

  # Fetch location (handle potential errors)
  location=$(curl -s "wttr.in/$city?format=%l" 2>/dev/null | cut -d ',' -f 1)
  if [ -z "$location" ]; then
    location="Unknown Location"
  fi

  # Fetch temperature and icon (handle potential errors)
  weather_info=$(curl -s "wttr.in/$city?format=%t+%C+%c" 2>/dev/null)
  if [ -z "$weather_info" ]; then
    temperature="Unknown"
  else
    temperature=$(echo "$weather_info" | tr -d '+')
  fi

  # Combine location and temperature
  result="$location, $temperature"

  # Remove trailing whitespace
  result="${result%"${result##*[![:space:]]}"}"

  # Display the result
  echo "$result"
}

# Function to continuously check network connectivity
check_network() {
  while true; do
    if ping -c 3 8.8.8.8 &>/dev/null; then
      # Connected, wait for 30 minutes
      sleep 1800 # 30 minutes * 60 seconds/minute
    else
      # Not connected, wait for 20 seconds
      sleep 20
    fi

    # Check connectivity again after waiting
    if ping -c 3 8.8.8.8 &>/dev/null; then
      # Send signal to the main process if connected
      kill -USR1 $$
      return 0
    fi
  done
}

# Trap USR1 signal
trap 'get_weather; exit 0' USR1

# Initial network connectivity check
if ping -c 3 8.8.8.8 &>/dev/null; then
  get_weather
  # Start network check after 30 minutes
  sleep 1800
  check_network &
  wait
else
  echo "Weather: 󱚵"
  # Start network check after 20 seconds
  sleep 20
  check_network &
  wait
fi
