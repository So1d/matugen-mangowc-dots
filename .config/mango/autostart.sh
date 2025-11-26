swww-daemon

swaync &
flatpak run com.discordapp.Discord &


bash $HOME/.config/mango/scripts/preload_thumbnails.sh
swww img "$HOME/.config/matugen/wallpapers/current_wallpaper" \
--transition-type any \
--transition-step 15 \
--transition-fps 60
 disown
