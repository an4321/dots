#!/bin/env bash

export DISPLAY=:0
export XDG_SESSION_TYPE="x11"

feh --bg-fill ~/Pictures/Wallpapers -z &

while true; do
    DATE=$(date +"󰥔 %H:%M | 󰭨 %b %d (%a) %Y")
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=" 󱐋 $BATTERY% | $DATE "
    xsetroot -name "$STATUS"
    sleep 1
done &

while clipnotify; do
    xclip -selection clipboard -o | cliphist store &
done &

exec dwm
