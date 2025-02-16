#!/bin/bash

if ping -c 3 google.com &>/dev/null; then
  location=Sontay
  weather=$(curl -s "wttr.in/$location?format=%t+%c" | tr -d '\r')
  weather=$(echo "$weather" | tr -d '\n')

  echo "$location, $weather" | sed 's/[[:space:]]*$//' | tr -d '+'
else
  echo "No Internet."
fi
