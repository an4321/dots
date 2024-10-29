#!/bin/env bash

export DISPLAY=:0
export XDG_SESSION_TYPE="x11"

xrandr --output eDP --primary --mode 1920x1200 --pos 0x1080 --output HDMI-A-0 --off --output DisplayPort-0 --mode 1920x1080 --pos 0x0
setbg -r

while true; do
    DATE=$(date +"󰥔 %H:%M | 󰭨 %b %d (%a) %Y")
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=" 󱐋 $BATTERY% | $DATE "
    xsetroot -name "$STATUS"
    sleep 60
done &

copyq &

exec dwm
