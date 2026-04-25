#!/bin/bash

# Initialize default values
wifi_info=" Off"
bat_info=" --%"
layout_info=" -"
cnt=0

while true; do
    # --- CẬP NHẬT TỨC THÌ (0.1s) ---
    
    # Volume
    wpctl_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    vol=$(echo "$wpctl_status" | awk '{print int($2 * 100)}')
    if [[ "$wpctl_status" == *"[MUTED]"* ]]; then
        vol_icon=""
        vol_text="Mute"
    else
        vol_icon=""
        vol_text="$vol%"
    fi
    
    # Fcitx5
    fcitx_raw=$(fcitx5-remote -n 2>/dev/null)
    [[ "$fcitx_raw" == *"us"* ]] && fcitx_short="EN" || fcitx_short="VI"
    
    # Date and Time
    date_time=$(date +'%a, %d/%m/%Y | %H:%M')

    # --- CẬP NHẬT NHANH (0.5s) ---
    # Layout cập nhật nhanh hơn để bạn thấy thay đổi ngay khi nhấn phím
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

    # --- CẬP NHẬT CHẬM (2.0s) ---
    # Wifi và Pin không cần cập nhật quá nhanh, để đây giúp giảm tải CPU
    if (( cnt % 20 == 0 )); then
        wifi_ssid=$(iwctl station wlan0 show 2>/dev/null | grep "Connected network" | sed 's/.*Connected network *//' | xargs)
        if [ -n "$wifi_ssid" ]; then
            wifi_info=" $wifi_ssid"
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
            bat_info=" $bat_cap%"
        fi
    fi

    # Hiển thị
    echo " $date_time | $layout_info |  $fcitx_short | $vol_icon $vol_text | $wifi_info | $bat_info"
    
    cnt=$((cnt+1))
    # Reset cnt nếu quá lớn để tránh tràn số (không bắt buộc nhưng nên có)
    if (( cnt > 1000 )); then cnt=0; fi
    
    sleep 0.1
done
