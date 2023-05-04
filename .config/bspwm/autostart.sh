#!/bin/bash

# pgrep -x doesn't seem to work for this. No idea why...
# This is used to make sure that things only get executed once
is_running() {
	ps -aux | awk "!/grep/ && /$1/"
}

feh --bg-fill ~/Pictures/kyojin.jpg &
xsetroot -cursor_name left_ptr

# Wait to let the X-Session start up correctly
sleep 1

~/.config/polybar/launch_bspwm.sh

# Notification daemon
[[ $(is_running 'deadd-notification-center') ]] || deadd-notification-center &

# Network manager
[[ $(is_running 'nm-applet') ]] || nm-applet &

# Bring in mate utils for managing the session
[[ $(is_running 'mate-settings-daemon') ]] || mate-settings-daemon &
[[ $(is_running 'mintupdate-launcher') ]] || mintupdate-launcher &
[[ $(is_running 'mate-power-manager') ]] || mate-power-manager &

#[[ $(is_running 'compton') ]] || /usr/bin/compton &
[[ $(is_running 'picom') ]] || picom --config ~/.config/picom/picom.conf &

# Polkit agent for password prompts
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# Start the keyring daemon for managing
[[ $(is_running 'gnome-keyring-daemon') ]] || gnome-keyring-daemon --daemonize --login &

# Key Ring
[[ $(is_running 'gnome-keyring-daemon') ]] || gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg &

# Sound
[[ $(is_running 'pasystray') ]] || pasystray &

# Color filter
[[ $(is_running 'redshift-gtk') ]] || redshift-gtk &

# Playerctl Daemon
playerctld daemon

#clipit &

numlockx on &

# [[ $(is_running 'ulauncher') ]] || ulauncher &

unclutter &
#ibus-daemon --xim --daemonize $

# [[ $(is_running 'kdeconnect-indicator') ]] || kdeconnect-indicator &

# conky -c ~/.config/bspwm/scripts/system-overview &
# conky -c ~/.config/bspwm/scripts/system-shortcuts &
