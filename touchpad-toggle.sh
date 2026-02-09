#!/bin/bash

# Touchpad toggle script for Hyprland
# Toggles touchpad enabled/disabled state using file-based persistence

DEVICE=$(hyprctl devices | grep touch | sed 's/^[[:space:]]*//')

if [ -z "$DEVICE" ]; then
    notify-send -u critical "No touchpad device found"
    exit 1
fi

HYPRLAND_VARIABLE="device[$DEVICE]:enabled"
STATUS_FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/touchpad.status"

enable_touchpad() {
    printf "true" > "$STATUS_FILE"
    notify-send -u normal "Touchpad: Enabled"
    hyprctl keyword "$HYPRLAND_VARIABLE" true
}

disable_touchpad() {
    printf "false" > "$STATUS_FILE"
    notify-send -u normal "Touchpad: Disabled"
    hyprctl keyword "$HYPRLAND_VARIABLE" false
}

if [ ! -f "$STATUS_FILE" ]; then
    enable_touchpad
elif [ "$(cat "$STATUS_FILE")" = "true" ]; then
    disable_touchpad
else
    enable_touchpad
fi
