#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-6"
theme="style-5"
rasi="$dir/$theme.rasi"

purge_cmd="--- CLEAR ALL HISTORY ---"

list_data=$(echo -e "$purge_cmd"; cliphist list | while read -r line; do
    if [[ "$line" == *'[[ binary'* ]]; then
        id=$(echo "$line" | cut -f1)
        [ ! -f "/tmp/clip_$id.png" ] && cliphist decode "$id" > "/tmp/clip_$id.png"
        echo -en "$line\0icon\x1f/tmp/clip_$id.png\n"
    else
        echo -e "$line"
    fi
done)

selected=$(echo -e "$list_data" | rofi -dmenu -i -theme "$rasi" -p "Clipboard" -show-icons)

if [[ "$selected" == "$purge_cmd" ]]; then
    confirm=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Are you sure?" -theme "$rasi")
    if [[ "$confirm" == "Yes" ]]; then
        cliphist wipe && notify-send "Clipboard" "History cleared"
    fi
elif [ -n "$selected" ]; then
    echo "$selected" | cliphist decode | wl-copy
fi
