#!/bin/bash

swayidle \
    timeout 300 'swaylock -f -C ~/.config/swaylock/swaylock.conf' \
	timeout 330 "wlopm --off '*'" \
	resume "wlopm --on '*'" \
	before-sleep 'swaylock -f -C ~/.config/swaylock/swaylock.conf'
