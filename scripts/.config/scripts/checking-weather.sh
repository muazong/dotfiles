#!/bin/bash
# The most sincere thanks to Gemini - Google :D

# Function to fetch and display weather information
get_weather() {
  city=Sontay

  # Fetch temperature and icon (handle potential errors)
  weather_info=$(curl -s "wttr.in/$city?format=%t+%c" 2>/dev/null)
  if [ -z "$weather_info" ]; then
    temperature="Unknown"
  else
    temperature=$(echo "$weather_info" | tr -d '+')
  fi

  # Combine location and temperature
  result="$city, $temperature"

  # Remove trailing whitespace
  result="${result%"${result##*[![:space:]]}"}"

  # Display the result
  echo "$result"
}

# Function to continuously check network connectivity and get weather if connected
check_network() {
  while true; do
    if ping -c 3 8.8.8.8 &>/dev/null; then
      # Connected
      get_weather
      return 0 # Exit the check_network function
    else
      # Not connected
      echo "No Network"
      sleep 20
    fi
  done
}

# Initial check and weather retrieval (or "No Network" if offline)
if ping -c 3 8.8.8.8 &>/dev/null; then
  get_weather
else
  echo "No Network"
fi

# Start the network checker in the background.  No need for signals or traps.
check_network &
network_checker_pid=$!

# Keep the script running (important: this prevents the background check_network from exiting)
while true; do
  sleep 3600 # Sleep for a long time. The background process will handle updates.
done

# Ensure the background process is stopped when the script exits (optional but good practice)
trap 'kill "$network_checker_pid" 2>/dev/null; wait "$network_checker_pid" 2>/dev/null; exit' INT TERM EXIT
