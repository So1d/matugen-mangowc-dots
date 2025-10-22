swww-daemon

swaync &

xsettingsd &
bash $HOME/.config/sway/scripts/gammarelay.sh
bash $HOME/.config/mango/scripts/preload_thumbnails.sh
swww img "$HOME/.config/matugen/wallpapers/current_wallpaper" \
--transition-type any \
--transition-step 15 \
--transition-fps 60
 disown
