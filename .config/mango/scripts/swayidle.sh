#!/bin/bash

swayidle \
    timeout 300 'swaylock -f -C ~/.config/swaylock/swaylock.conf' \
	timeout 330 'wlr-dpms off' \
	resume 'wlr-dpms on' \
	before-sleep 'swaylock -f -C ~/.config/swaylock/swaylock.conf'
