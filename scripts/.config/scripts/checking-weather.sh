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

# Function to continuously check network connectivity
check_network() {
  while true; do
    if ping -c 3 8.8.8.8 &>/dev/null; then
      # Connected
      # Send signal to the main process
      kill -USR1 $$
      return 0 # Exit the check_network function
    else
      # Not connected, wait for 20 seconds
      sleep 20
    fi
  done
}

# Trap USR1 signal
trap 'get_weather' USR1 # Only get_weather, don't exit

# Variable to store the check_network process ID
network_checker_pid=""

# Function to start the network checker in the background
start_network_checker() {
  check_network &
  network_checker_pid=$!
}

# Function to stop the network checker
stop_network_checker() {
  if [ -n "$network_checker_pid" ]; then
    kill "$network_checker_pid" 2>/dev/null
    wait "$network_checker_pid" 2>/dev/null # Wait for the process to terminate
    network_checker_pid=""
  fi
}

# Initial check and weather retrieval
if ping -c 3 8.8.8.8 &>/dev/null; then
  get_weather
  start_network_checker
else
  echo "Weather: 󱚵"
  start_network_checker
fi

# Main loop for periodic weather updates
while true; do
  sleep 1200 # 20 minutes * 60 seconds/minute

  # Check if network is still up before trying to get weather
  if ping -c 3 8.8.8.8 &>/dev/null; then
    get_weather
  else
    echo "Network down, skipping weather update."
  fi
done

# Ensure the network checker is stopped when the script exits (optional but good practice)
trap 'stop_network_checker; exit' INT TERM EXIT
