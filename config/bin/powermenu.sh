#!/usr/bin/env bash

# ~/.config/bin/powermenu.sh

# Requiere: rofi, ~/.config/rofi/powermenu.rasi

# y, para Bloquear/Suspender, alguno de: i3lock(-color) | betterlockscreen | physlock



uptime_txt=$(uptime -p 2>/dev/null | sed 's/^up //')



# --- detecta un locker disponible (ajustá el orden a gusto) ---

lock() {

    if command -v betterlockscreen >/dev/null 2>&1; then

        betterlockscreen -l &

    elif command -v i3lock-color >/dev/null 2>&1; then

        i3lock-color -c 1B1420 &

    elif command -v i3lock >/dev/null 2>&1; then

        i3lock -c 1B1420 &

    elif command -v physlock >/dev/null 2>&1; then

        sudo -n physlock &

    else

        notify-send "Powermenu" "No encontré un locker instalado (i3lock / betterlockscreen / physlock)."

        return 1

    fi

    disown

}



options=" Bloquear\n Suspender\n Apagar\n Reiniciar\n Salir"



chosen=$(echo -e "$options" | rofi -dmenu \

    -mesg "Sesión activa · ${uptime_txt:-—}" \

    -theme ~/.config/rofi/powermenu.rasi \

    -a 2 -u 3)   # 2 = "Apagar" (fila activa), 3 = "Reiniciar" (fila urgente)



case "$chosen" in

    *Bloquear*)

        lock

        ;;

    *Suspender*)

        lock && sleep 0.3   # bloquea ANTES de suspender, si no, arranca desbloqueado

        systemctl suspend

        ;;

    *Apagar*)

        systemctl poweroff

        ;;

    *Reiniciar*)

        systemctl reboot

        ;;

    *Salir*)

        bspc quit   # cambiá esto por el comando de salida de tu WM

        ;;

esac
