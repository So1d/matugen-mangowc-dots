swayidle -w \
  timeout 300 'swaylock -C ~/.config/swaylock/swaylock.conf' \
  timeout 330 'wlr-randr --output eDP-1 --off' \
    resume 'wlr-randr --output eDP-1 --on' \
  before-sleep 'swaylock -C ~/.config/swaylock/swaylock.conf'
