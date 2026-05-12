#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-6"
theme='style-5'

CLEAR_LABEL=" Clear All Notifications"

list_notifications() {
    echo "$CLEAR_LABEL"
    (makoctl list -j && makoctl history -j) | jq -s 'add | reverse | .[] | "\(.summary): \(.body)"'
}

selected=$(list_notifications | rofi \
    -dmenu \
    -theme "${dir}/${theme}.rasi")

if [[ "$selected" == "$CLEAR_LABEL" ]]; then
    makoctl dismiss -a
    makoctl history-clear
    notify-send -t 2000 "System" "All notifications purged."
elif [[ -n "$selected" ]]; then
    makoctl restore
fi
