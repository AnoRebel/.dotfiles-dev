#!/usr/bin/env sh

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
#polybar top &
polybar -c ~/.config/hypr/polybar/config -r bottom &
polybar -c ~/.config/hypr/polybar/config -r center &
polybar -c ~/.config/hypr/polybar/config -r topright &

echo "Bars launched..."

# remember: chmod u+x ./launch.sh
