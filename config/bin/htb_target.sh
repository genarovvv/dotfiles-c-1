#!/bin/sh

# Author: z1rov

TARGET_FILE="$HOME/.config/bin/target"

ip_target=$(awk '{print $1}' "$TARGET_FILE")
name_target=$(awk '{print $2}' "$TARGET_FILE")

# ==========================================
# Copy target IP
# ==========================================

if [ "$1" = "--copy" ]; then
    if [ -n "$ip_target" ]; then
        printf '%s' "$ip_target" | xclip -selection clipboard
    fi
    exit 0
fi

# ==========================================
# Polybar output
# ==========================================

if [ -n "$ip_target" ] && [ -n "$name_target" ]; then
    printf '%%{F#0077B6}󰣇 %%{F#000000}%s - %s%%{F-}\n' \
        "$ip_target" "$name_target"

elif [ -n "$ip_target" ]; then
    printf '%%{F#0077B6}󰣇 %%{F#000000}%s%%{F-}\n' \
        "$ip_target"

else
    printf '%%{F#0077B6}󰣇 %%{F#888888} No target%%{F-}\n'
fi

