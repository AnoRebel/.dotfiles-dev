#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Bspwm bar
echo "---" | tee -a /tmp/polybar_bspwm_hdmi.log
echo "---" | tee -a /tmp/polybar_bspwm_vga.log
polybar bspwm_hdmi 2>&1 | tee -a /tmp/polybar_bspwm_hdmi.log & disown
polybar bspwm_vga 2>&1 | tee -a /tmp/polybar_bspwm_vga.log & disown

echo "Bspwm bars launched..."
