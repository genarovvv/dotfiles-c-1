#!/usr/bin/env bash
#
# ~/.config/bin/theme-menu.sh
#

set -euo pipefail

BIN_DIR="$HOME/.config/bin"
THEMES_DIR="$BIN_DIR/themes"

mapfile -t theme_files < <(
    find "$THEMES_DIR" -maxdepth 1 -type f -name '*.sh' -printf '%f\n' |
    sed 's/\.sh$//' |
    sort
)

if [[ ${#theme_files[@]} -eq 0 ]]; then
    notify-send -a "theme" "Sin temas" "No hay temas en $THEMES_DIR"
    exit 1
fi

chosen="$(
    printf '%s\n' "${theme_files[@]}" |
    rofi -dmenu \
         -i \
         -p "Tema" \
         -theme-str '@import "colors-launcher.rasi"'
)"

[[ -z "$chosen" ]] && exit 0

exec "$BIN_DIR/set-theme.sh" "$chosen"

