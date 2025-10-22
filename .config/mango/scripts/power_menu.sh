#!/bin/bash

OPTIONS=" Lock\n Logout\n Suspend\n Reboot\n Shutdown"

SELECTED=$(echo -e "$OPTIONS" | fuzzel --dmenu --prompt "System:" --lines 5 --width 11)


if [ -z "$SELECTED" ]; then
    exit 0
fi

case "$SELECTED" in
    " Lock")
        swaylock -C ~/.config/swaylock/swaylock.conf
        ;;
    " Logout")
        mmsg -q
        ;;
    " Suspend")
        systemctl suspend
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
esac
