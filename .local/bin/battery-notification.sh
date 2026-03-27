#!/usr/bin/env bash
NOTIFY_SENT_CRITICAL=""
NOTIFY_SENT_LOW=""
NOTIFY_SENT_MID=""
while true; do
    # Battery status and percentage information
    BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    # Battery is not plugged in
    if [[ $BATTERY_STATUS == "Discharging" ]]; then
        # Notify based on battery percentage
        if [[ $BATTERY_LEVEL -le 15 && -z $NOTIFY_SENT_CRITICAL ]]; then
            notify-send -u critical -i battery-caution "Battery critical - $BATTERY_LEVEL%"
            NOTIFY_SENT_CRITICAL="true"
        elif [[ $BATTERY_LEVEL -le 30 && -z $NOTIFY_SENT_LOW ]]; then
            notify-send -u normal -i battery-low "Battery low - $BATTERY_LEVEL%"
            NOTIFY_SENT_LOW="true"
        elif [[ $BATTERY_LEVEL -le 50 && $BATTERY_LEVEL -gt 30 && -z $NOTIFY_SENT_MID ]]; then
            notify-send -u low "Battery at - $BATTERY_LEVEL%"
            NOTIFY_SENT_MID="true"
        fi
    fi
    # Reset messages sent
    if [[ $BATTERY_LEVEL -gt 15 || "$BATTERY_STATUS" == "Charging" ]]; then
        NOTIFY_SENT_CRITICAL=""
    fi
    if [[ $BATTERY_LEVEL -gt 30 || "$BATTERY_STATUS" == "Charging" ]]; then
        NOTIFY_SENT_LOW=""
    fi
    if [[ $BATTERY_LEVEL -gt 50 || "$BATTERY_STATUS" == "Charging" ]]; then
        NOTIFY_SENT_MID=""
    fi
    sleep 60
done
