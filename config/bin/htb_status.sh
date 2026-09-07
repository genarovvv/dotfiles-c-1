#!/bin/sh

# Author: z1rov

ACTION="$1"

# Obtener interfaz e IP de la ruta principal
iface=$(ip -4 route get 1.1.1.1 2>/dev/null |
    awk '{
        for (i = 1; i <= NF; i++)
            if ($i == "dev")
                print $(i+1)
    }' | head -n1)

ipaddr=$(ip -4 route get 1.1.1.1 2>/dev/null |
    awk '{
        for (i = 1; i <= NF; i++)
            if ($i == "src")
                print $(i+1)
    }' | head -n1)

# Icono según interfaz
case "$iface" in
    tun*|wg*|ppp*)
        icon="󰒃"
        ;;
    eth*|enp*|eno*|ens*)
        icon="󰈀"
        ;;
    wlan*|wlp*)
        icon="󰖩"
        ;;
    *)
        icon="󰖟"
        ;;
esac

# Copiar IP
if [ "$ACTION" = "--copy" ]; then
    if [ -n "$ipaddr" ]; then
        printf '%s' "$ipaddr" | xclip -selection clipboard
    fi
    exit 0
fi

# Mostrar
if [ -n "$ipaddr" ]; then
    printf '%%{F#0077B6}%s %%{F#000000}%s%%{F-}\n' "$icon" "$ipaddr"
else
    printf '%%{F#0077B6}󰖟 %%{F#888888}Disconnected%%{F-}\n'
fi

