#!/bin/bash

# Fetch location
location=$(curl -s "wttr.in/Hanoi?format=%l" | cut -d ',' -f 1)

# Fetch temperature and icon
temperature=$(curl -s "wttr.in/Hanoi?format=%t+%c" | tr -d '+')

# Combine location, temperature, and icon with a comma
result=$(echo "$location, $temperature")

# Remove trailing whitespace
result="${result%"${result##*[![:space:]]}"}"

# Display the result
echo "$result"
