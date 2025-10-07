#!/usr/bin/env bash

WAYBAR_CMD="waybar"

pid=$(pgrep -u "$USER" -x waybar | head -n1)

if [[ -n "$pid" ]]; then
  kill "$pid"
else
  setsid $WAYBAR_CMD >/dev/null 2>&1 &
  disown
fi
