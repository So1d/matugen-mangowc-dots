#!/bin/bash
# Script para alternar o layout XKB de latam para br e vice-versa.

CONFIG_FILE="$HOME/.config/mango/io.conf"

# 1. Busca a linha atual do layout e remove o prefixo 'xkb_rules_layout='
CURRENT_LAYOUT_LINE=$(grep '^xkb_rules_layout=' "$CONFIG_FILE" | head -n 1)

if [ -z "$CURRENT_LAYOUT_LINE" ]; then
    notify-send "ERRO XKB" "Linha 'xkb_rules_layout' não encontrada no io.conf!"
    exit 1
fi

# Extrai APENAS o primeiro layout (o layout ATIVO no momento)
ACTIVE_LAYOUT=$(echo "$CURRENT_LAYOUT_LINE" | sed 's/^xkb_rules_layout=\([^,]*\).*$/\1/')


# 2. DECIDE O PRÓXIMO ESTADO (Toggle Lógica)
if [ "$ACTIVE_LAYOUT" = "latam" ]; then
    NEW_LAYOUT_LIST="br,latam"
    NEW_ACTIVE_NAME="ABNT2 (BR)"
elif [ "$ACTIVE_LAYOUT" = "br" ]; then
    NEW_LAYOUT_LIST="latam,br"
    NEW_ACTIVE_NAME="LATAM"
else
    # Fallback
    NEW_LAYOUT_LIST="latam,br"
    NEW_ACTIVE_NAME="LATAM (Forçado)"
fi


# 3. ATUALIZA O ARQUIVO (usando o padrão /s// para substituir a linha inteira)
sed -i "1,/^xkb_rules_layout=/s/^xkb_rules_layout=.*/xkb_rules_layout=$NEW_LAYOUT_LIST/" "$CONFIG_FILE"

# 4. NOTIFICAÇÃO RÁPIDA (Duração de 500ms)
# O parâmetro -t (tempo) garante que a notificação suma rapidamente.
# O parâmetro -i (ícone) dá um visual legal, se disponível.
notify-send -t 1500 \
                -u critical \
                -t 1500 \
                -h "string:x-canonical-private-synchronous:osd-la" \
                -h "boolean:transient:true" \ "Teclado Ativo" "$NEW_ACTIVE_NAME"

# 5. Força a recarga do MangoWC
if mmsg -d reload_config; then
    echo "Layout $NEW_LAYOUT_LIST ativado com sucesso."
else
    notify-send "ERRO XKB" "Falha ao recarregar o MangoWC. Recarregue manualmente."
fi
