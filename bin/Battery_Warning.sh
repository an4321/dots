#!/bin/bash

while true
do
    # Get the current battery capacity
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$capacity" -lt 20 ]; then
        # Send a notification (replace 'notify-send' with your preferred notification command)
        notify-send -i ~/Pictures/Icons/low-battery.png "Low Battery" "Battery capacity is $capacity%!"
    fi

    sleep 600  # 10min
done
