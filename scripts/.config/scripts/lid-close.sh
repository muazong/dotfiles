#!/bin/env bash

hyprctl dispatch workspace 10

sleep 0.3

hyprctl dispatch dpms off
hyprctl dispatch exec hyprlock
