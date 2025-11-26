#!/usr/bin/env bash

FUZZEL_ARGS="--dmenu --width 16 --lines 3 --prompt 'Mirror menu'"

check_deps() {
    for dep in wl-mirror fuzzel slurp; do
        if ! command -v "$dep" &> /dev/null; then
            notify-send "Erro" "Falta dependencia: $dep" -u critical
            exit 1
        fi
    done
}

check_deps

CHOICE=$(echo -e "Espelhar Saida\nEspelhar Regiao\nMatar Espelhos" | fuzzel $FUZZEL_ARGS)

case "$CHOICE" in
    "Espelhar Saida")
        # Opcoes hardcoded conforme o hardware
        OUTPUT=$(echo -e "eDP-1\nHDMI-A-1" | fuzzel --dmenu --width 10 --lines 2 --prompt "Monitor > ")

        if [ -n "$OUTPUT" ]; then
            nohup wl-mirror "$OUTPUT" >/dev/null 2>&1 &
            notify-send "wl-mirror" "Espelhando $OUTPUT"
        fi
        ;;

    "Espelhar Regiao")
        REGION=$(slurp)
        if [ -n "$REGION" ]; then
            nohup wl-mirror --region "$REGION" >/dev/null 2>&1 &
        fi
        ;;

    "Matar Espelhos")
        pkill wl-mirror
        notify-send "wl-mirror" "Encerrado"
        ;;
esac
