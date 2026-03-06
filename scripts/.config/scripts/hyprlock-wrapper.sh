#!/bin/bash

hyprlock

loginctl unlock-session && killall hyprlock
