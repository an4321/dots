
while true; do
    # Get the current date in the desired format
    DATE=$(date +"%a %e %b %H:%M")
    
    # Retrieve battery percentage
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)

    # Format status line
    STATUS="$DATE | Battery: $BATTERY%"

    # Update dwm status bar
    xsetroot -name "$STATUS"

    sleep 1
done &

# xrandr --output eDP-1 --mode 1920x1200
# xrandr --output DP-1 --off
# feh --bg-fill ~/Pictures/Wallpapers/andreas.jpg
picom &
exec dwm
