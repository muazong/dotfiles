#!/bin/bash

# Initialize default values
wifi_info=" Off"
bat_info=" --%"
cnt=0

while true; do
    # --- INSTANT UPDATES (0.1s) ---
    
    # Volume
    wpctl_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    vol=$(echo "$wpctl_status" | awk '{print int($2 * 100)}')
    if [[ "$wpctl_status" == *"[MUTED]"* ]]; then
        vol_icon=""
        vol_text="Mute"
    else
        vol_icon=""
        vol_text="$vol%"
    fi
    
    # Fcitx5 (EN/VI)
    fcitx_raw=$(fcitx5-remote -n 2>/dev/null)
    [[ "$fcitx_raw" == *"us"* ]] && fcitx_short="EN" || fcitx_short="VI"
    
    # Date and Time
    date_time=$(date +'%a, %d/%m/%Y | %H:%M')

    # --- SLOW UPDATES (every 2s) ---
    if (( cnt % 20 == 0 )); then
        wifi_ssid=$(iwctl station wlan0 show 2>/dev/null | grep "Connected network" | sed 's/.*Connected network *//' | xargs)
        
        if [ -n "$wifi_ssid" ]; then
            wifi_info=" $wifi_ssid"
        else
            wifi_info=" Off"
        fi
        
        # Battery
        bat_cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        bat_stat=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
        if [ "$bat_stat" == "Charging" ]; then
            bat_info=" $bat_cap%"
        elif [ -z "$bat_cap" ]; then
            bat_info=" AC"
        else
            bat_info=" $bat_cap%"
        fi
    fi

    # Display (Time | Fcitx5 | Volume | Wifi | Battery)
    echo " $date_time |  $fcitx_short | $vol_icon $vol_text | $wifi_info | $bat_info"
    
    cnt=$((cnt+1))
    sleep 0.1
done

