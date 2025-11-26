#!/bin/bash
export XDG_CURRENT_DESKTOP="wlroots"
echo "PATH: $PATH" >> /tmp/mango_env_log.txt

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WALL_COPY="$HOME/.config/matugen/wallpapers/current_wallpaper"
THUMBNAIL_DIR="$HOME/.cache/sway_wall_thumbnails"

mkdir -p "$(dirname "$WALL_COPY")"
mkdir -p "$THUMBNAIL_DIR"


generate_fuzzel_list() {
    find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | while read -r wall; do

        thumb_name=$(basename "$wall")
        thumbnail_path="$THUMBNAIL_DIR/$thumb_name.png"

        if [ ! -f "$thumbnail_path" ]; then
            echo "Gerando miniatura para $thumb_name..." >&2

            magick "$wall" -thumbnail 256x256^ -gravity center -extent 256x256 "$thumbnail_path"
        fi

        printf '%s\0icon\x1f%s\n' "$(basename "$wall")" "$thumbnail_path"
    done
}


SELECTED_BASENAME=$(generate_fuzzel_list | fuzzel --dmenu )

if [ -z "$SELECTED_BASENAME" ]; then
    echo "Nenhum wallpaper selecionado."
    exit 1
fi


SELECTION="$WALLPAPER_DIR/$SELECTED_BASENAME"

# Aplica de fato
cp "$SELECTION" "$WALL_COPY"
echo "pré matugem"
matugen  image "$WALL_COPY" #-t scheme-fidelity # -m light
#killall waybar
#nohup waybar &
mmsg -d reload_config
# Aplica no swaync
killall swaync
nohup swaync >/dev/null 2>&1 &

disown

swww img "$HOME/.config/matugen/wallpapers/current_wallpaper" \
--transition-type any \
--transition-step 35 \
--transition-fps 60


exit 0
