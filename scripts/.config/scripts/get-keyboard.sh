#!/bin/bash
layout=$(fcitx5-remote -n)

case "$layout" in
"keyboard-us") echo "EN" ;;
"unikey") echo "VI" ;;
*) echo "$layout" ;;
esac

pkill -RTMIN+1 waybar 2>/dev/null
