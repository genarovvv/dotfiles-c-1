#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar primary &
polybar secondary &
polybar terciary &
#polybar quaternary &
polybar quinary &
polybar log &
polybar top &
polybar primary -c ~/.config/polybar/workspace.ini
