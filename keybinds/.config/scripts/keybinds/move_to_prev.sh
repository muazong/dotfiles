#!/bin/bash
id=$(hyprctl activeworkspace -j | jq .id)
hyprctl dispatch movetoworkspace $((id - 1))
