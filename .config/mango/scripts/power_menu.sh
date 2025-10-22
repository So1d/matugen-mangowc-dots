#!/bin/bash

OPTIONS=" Lock\n Logout\n Suspend\n Reboot\n Shutdown"

SELECTED=$(echo -e "$OPTIONS" | fuzzel --dmenu --prompt "System:" --lines 5 --width 11)

# Se nada for selecionado, saia.
if [ -z "$SELECTED" ]; then
    exit 0
fi

# Execução do comando baseado na seleção
case "$SELECTED" in
    " Lock")
        # Comando para bloquear a tela (swaylock)
        swaylock -C ~/.config/swaylock/swaylock.conf
        ;;
    " Logout")
        # Comando IPC nativo para encerrar o mango
        # O -q do mmsg força a saída limpa (Quit mango)
        mmsg -q
        ;;
    " Suspend")
        # Comando universal para suspender o sistema
        systemctl suspend
        ;;
    " Reboot")
        # Comando universal para reiniciar o sistema
        systemctl reboot
        ;;
    " Shutdown")
        # Comando universal para desligar o sistema
        systemctl poweroff
        ;;
esac
