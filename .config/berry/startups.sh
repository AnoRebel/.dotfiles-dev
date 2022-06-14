#!/usr/bin/env bash

## Autostart Programs

# Kill already running process
_ps=(sxhkd polybar picom xfce-polkit xfce4-power-manager)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done


# Polkit agent
#/usr/lib/xfce-polkit/xfce-polkit &

# Enable power management
#xfce4-power-manager &

## Enable Hot Keys 
sxhkd -c ~/.config/berry/sxhkdrc &


# Set/Restore wallpaper
feh --bg-fill ~/Pictures/Wallpapers/kyojin.jpg &

# Lauch polybar
~/.config/berry/polybar.sh

# Redshift
redshift-gtk &

# Lauch compositor
picom -c ~/.config/berry/picom.conf --experimental-backends &
