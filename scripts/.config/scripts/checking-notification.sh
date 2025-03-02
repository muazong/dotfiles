#!/bin/bash

if swaync-client -D | grep -q "true"; then
  echo "󱙍"
else
  NOTIF_COUNT=$(swaync-client -c)
  if [ "$NOTIF_COUNT" -gt 0 ]; then
    echo "󱥁 $NOTIF_COUNT"
  else
    echo "󰍡"
  fi
fi
