#!/bin/bash
id=$(hyprctl activeworkspace -j | jq .id)
hyprctl dispatch workspace $((id + 1))
