#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-6"
theme="style-5"
rasi="$dir/$theme.rasi"

cliphist list | while read -r line; do
    if [[ "$line" == *'[[ binary'* ]]; then
        id=$(echo "$line" | cut -f1)
        [ ! -f "/tmp/clip_$id.png" ] && cliphist decode "$id" > "/tmp/clip_$id.png"
        echo -en "$line\0icon\x1f/tmp/clip_$id.png\n"
    else
        echo -e "$line"
    fi
done | rofi -dmenu -i -theme "$rasi" -p "Clipboard" -show-icons | cliphist decode | wl-copy
