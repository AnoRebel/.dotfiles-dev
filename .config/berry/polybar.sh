if [[ ! `pidof polybar` ]]; then
		polybar -q main -c "$HOME"/.config/berry/polybar/config &
	else
		polybar-msg cmd restart
	fi
