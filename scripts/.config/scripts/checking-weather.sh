#!/bin/bash

# Process command-line arguments
while getopts ":n:" opt; do
  case $opt in
  n) city="$OPTARG" ;;                                   # City name
  \?) echo "Invalid option: -$OPTARG" >&2 ;;             # Invalid option
  :) echo "Option -$OPTARG requires an argument." >&2 ;; # Missing argument
  esac
done

# Set default city if no argument is provided
if [[ -z "$city" ]]; then
  city="Hanoi"
fi

# Fetch temperature and remove the degree symbol
temperature=$(curl -s "wttr.in/$city?format=%t" | tr -d '+')
temp_num=$(echo "$temperature" | sed 's/°C//') # Extract numerical value

# Determine temperature status
case "$temp_num" in
[3][0-5]*) # 30-35°C
  status="Hot"
  icon="☀️"
  ;;
[3][5-9]* | [4-9][0-9]*) # 35°C+, 40°C+
  status="Very Hot"
  icon="🔥"
  ;;
[2][5-9]*) # 25-29°C
  status="Warm"
  icon="⛅"
  ;;
[2][0-4]*) # 20-24°C
  status="Cool"
  icon="❄️"
  ;;
[1][5-9]*) # 15-19°C
  status="Cold"
  icon="❄️"
  ;;
[1][0-4]*) # 10-14°C
  status="Very Cold"
  icon="❄️"
  ;;
[0-9]*) # Below 10°C
  status="Freezing"
  icon="🥶"
  ;;
*)
  status="Unknown" # Error case
  ;;
esac

# Display the result
echo "$city: $temperature $icon ($status)"
