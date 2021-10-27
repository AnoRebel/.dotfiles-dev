#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Bspwm bar
echo "---" | tee -a /tmp/polybar_dp.log
echo "---" | tee -a /tmp/polybar_vga.log
polybar -r DP-1 2>&1 | tee -a /tmp/polybar_dp.log & disown
polybar -r VGA-1 2>&1 | tee -a /tmp/polybar_vga.log & disown

echo "Bspwm bars launched..."
