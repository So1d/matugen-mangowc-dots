#!/bin/bash

OPTIONS=" Lock\n Logout\n Suspend\n Reboot\n Shutdown"

SELECTED=$(echo -e "$OPTIONS" | fuzzel --dmenu --prompt "System:" --lines 5 --width 11)


if [ -z "$SELECTED" ]; then
    exit 0
fi

case "$SELECTED" in
    " Shutdown")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Suspend")
        systemctl suspend
        ;;
    " Lock")
        swaylock -C ~/.config/swaylock/swaylock.conf
        ;;
    " Logout")
        mmsg -q
        ;;

esac
