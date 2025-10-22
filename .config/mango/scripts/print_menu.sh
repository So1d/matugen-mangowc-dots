#!/bin/bash

# Script de Menu de Screenshot para MangoWC (usando mmsg, grim, slurp, fuzzel, jq)

SS_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SS_DIR"
SS_FILE="$SS_DIR/$(date +'%Y%m%d_%H%M%S').png"



MENU_OPTIONS="1. Área (Arquivo)\n2. Área (Clipboard)\n3. Tela Cheia (Arquivo)\n4. Tela Cheia (Clipboard)"

ACTION=$(echo -e "$MENU_OPTIONS" | fuzzel --dmenu --prompt="Screenshot:" --lines 4 --width 26)

# Use 'spawn_shell' no bind para rodar este script, e use 'sh -c' para garantir a execução
case "$ACTION" in
    "1. Área (Arquivo)")
        slurp | grim -g- "$SS_FILE" ;;
    "2. Área (Clipboard)")
        slurp | grim -g- - | wl-copy ;;
    "3. Tela Cheia (Arquivo)")
        sleep 0.2 && grim "$SS_FILE" ;;
    "4. Tela Cheia (Clipboard)")
        grim - | wl-copy ;;
esac

if [ -n "$ACTION" ]; then
    notify-send "Screenshot" "Captura: $ACTION"
fi

exit 0
