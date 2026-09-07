#!/usr/bin/env bash
set -euo pipefail
THEME="${1:-}"
CONF_DIR="$HOME/.config"
BIN_DIR="$CONF_DIR/bin"
THEME_DEF="$BIN_DIR/themes/${THEME}.sh"
STATE_DIR="$CONF_DIR/theme"
WALLPAPER_DIR="$CONF_DIR/wallpapers"
if [[ -z "$THEME" || ! -f "$THEME_DEF" ]]; then
    echo "Uso: set-theme.sh <pink|celeste|purple>" >&2
    echo "(no existe $THEME_DEF)" >&2
    exit 1
fi
source "$THEME_DEF"
mkdir -p "$STATE_DIR"
echo "$THEME_NAME" > "$STATE_DIR/current"
cat > "$STATE_DIR/current.sh" <<EOF
THEME_NAME="$THEME_NAME"
THEME_BG="$THEME_BG"
THEME_BG_ALT="$THEME_BG_ALT"
THEME_FG="$THEME_FG"
THEME_MUTED="$THEME_MUTED"
THEME_ACCENT="$THEME_ACCENT"
THEME_ACCENT2="$THEME_ACCENT2"
EOF
POLYBAR_DIR="$CONF_DIR/polybar"
BASE_COLORS="$POLYBAR_DIR/colors-base.ini"
OUT_COLORS="$POLYBAR_DIR/colors.ini"
if [[ -f "$BASE_COLORS" ]]; then
    {
        cat "$BASE_COLORS"
        echo ""
        echo "ac    = $THEME_ACCENT"
        echo "bg    = $THEME_BG"
        echo "fg    = $THEME_FG"
        echo "g     = $THEME_FG"
        echo "muted = $THEME_MUTED"
        echo "red   = $THEME_ACCENT2"
    } > "$OUT_COLORS"
else
    echo "Aviso: no existe $BASE_COLORS, no se regenero colors.ini" >&2
fi
ROFI_COLORS="$CONF_DIR/rofi/colors.rasi"
mkdir -p "$(dirname "$ROFI_COLORS")"
cat > "$ROFI_COLORS" <<EOF
* {
    bg:      $THEME_BG;
    bg-alt:  $THEME_BG_ALT;
    fg:      $THEME_FG;
    muted:   $THEME_MUTED;
    accent:  $THEME_ACCENT;
    accent2: $THEME_ACCENT2;
}
EOF
cat > "$CONF_DIR/rofi/colors-launcher.rasi" <<EOF
* {
    bg:       $THEME_BG;
    fg:       $THEME_FG;
    button:   $THEME_BG_ALT;
    accent:   $THEME_ACCENT;
}
EOF
THEME_WALL_DIR="$WALLPAPER_DIR/$THEME_NAME"
if [[ -d "$THEME_WALL_DIR" ]]; then
    mapfile -t imgs < <(find "$THEME_WALL_DIR" -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \))
    if [[ ${#imgs[@]} -gt 0 ]]; then
        pick="${imgs[$((RANDOM % ${#imgs[@]}))]}"
        feh --bg-fill "$pick"
    else
        echo "Aviso: $THEME_WALL_DIR no tiene imagenes" >&2
    fi
else
    echo "Aviso: no existe $THEME_WALL_DIR (crea wallpapers/$THEME_NAME/imgN.png)" >&2
fi
if command -v bspc >/dev/null 2>&1; then
    bspc config focused_border_color "$THEME_ACCENT"
    bspc config active_border_color  "$THEME_ACCENT"
fi
if [[ -x "$POLYBAR_DIR/launch.sh" ]]; then
    "$POLYBAR_DIR/launch.sh" >/dev/null 2>&1 &
    disown
fi
command -v notify-send >/dev/null 2>&1 && \
    notify-send -a "theme" "Tema: $THEME_NAME" "Wallpaper y colores actualizados" || true
