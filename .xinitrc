#!/bin/env bash

export DISPLAY=:0
export XDG_SESSION_TYPE="x11"

setbg -r

while true; do
    DATE=$(date +"󰥔 %H:%M | 󰭨 %b %d (%a) %Y")
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=" 󱐋 $BATTERY% | $DATE "
    xsetroot -name "$STATUS"
    sleep 60
done &

blueman-applet & copyq & dunst & battery_warning &

exec dwm
