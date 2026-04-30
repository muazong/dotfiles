#!/bin/bash

wifi_info=" Off"
bat_info=" --%"
layout_info=" -"
caps_info="󰪛 OFF"
cnt=0

while true; do
    wpctl_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    vol=$(echo "$wpctl_status" | awk '{print int($2 * 100)}')

    if [[ "$wpctl_status" == *"[MUTED]"* ]]; then
        vol_icon=""
        vol_text="Mute"
    else
        if [ "$vol" -lt 30 ]; then vol_icon=""; else vol_icon=""; fi
        vol_text="$vol%"
    fi

    fcitx_raw=$(fcitx5-remote -n 2>/dev/null)
    [[ "$fcitx_raw" == *"us"* ]] && fcitx_short="EN" || fcitx_short="VI"

    if brightnessctl --device='input*::capslock' get >/dev/null 2>&1; then
        caps_state=$(brightnessctl --device='input*::capslock' get)
        if [ "$caps_state" -eq 1 ]; then
            caps_info="󰪛 ON"
        else
            caps_info="󰪛 OFF"
        fi
    else
        caps_info="" 
    fi

    date_time=$(date +'%a, %d/%m/%Y | %H:%M')

    if (( cnt % 5 == 0 )); then
        layout_raw=$(swaymsg -t get_tree | jq -r '.. | objects | select(.nodes[]? | .focused == true) | .layout' 2>/dev/null)
        case "$layout_raw" in
            "splith") layout_info=" H" ;;
            "splitv") layout_info=" V" ;;
            "tabbed") layout_info=" Tab" ;;
            "stacked") layout_info=" Stk" ;;
            *) layout_info=" -" ;;
        esac
    fi

    if (( cnt % 20 == 0 )); then
        wifi_ssid=$(iwctl station wlan0 show 2>/dev/null | grep "Connected network" | sed 's/.*Connected network *//' | xargs)
        if [ -n "$wifi_ssid" ]; then
            rssi=$(iwctl station wlan0 show 2>/dev/null | grep -w "RSSI" | awk '{print $2}' | sed 's/[^0-9-]//g')
            if [ -n "$rssi" ]; then
                if (( rssi > -50 )); then icon="󰤨";
                elif (( rssi > -65 )); then icon="󰤥";
                elif (( rssi > -80 )); then icon="󰤢";
                else icon="󰤟"; fi
                wifi_info="$icon $wifi_ssid"
            else
                wifi_info=" $wifi_ssid"
            fi
        else
            wifi_info=" Off"
        fi

        bat_cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        bat_stat=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

        if [ "$bat_stat" == "Charging" ]; then
            bat_info=" $bat_cap%"
        elif [ -z "$bat_cap" ]; then
            bat_info=" AC"
        else
            if [ "$bat_cap" -lt 20 ]; then icon="";
            elif [ "$bat_cap" -lt 40 ]; then icon="";
            elif [ "$bat_cap" -lt 60 ]; then icon="";
            elif [ "$bat_cap" -lt 80 ]; then icon="";
            else icon=""; fi
            bat_info="$icon $bat_cap%"
        fi
    fi

    echo " $date_time | $layout_info | $caps_info |  $fcitx_short | $vol_icon $vol_text | $wifi_info | $bat_info"

    cnt=$((cnt+1))
    if (( cnt > 1000 )); then cnt=0; fi

    sleep 0.1
done
