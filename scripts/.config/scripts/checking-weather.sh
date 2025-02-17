#!/bin/bash

if ping -c 3 8.8.8.8 &>/dev/null; then
  location="Sontay"
  weather=$(curl -s "wttr.in/$location?format=%t+%c")

  if [[ -n "$weather" ]]; then
    weather=$(echo "$weather" | tr -d '\r')
    weather=$(echo "$weather" | tr -d '\n')

    echo "$location, $weather" | sed 's/[[:space:]]*$//' | tr -d '+'
  else
    echo "No Information."
  fi
else
  echo "No Network."
fi
