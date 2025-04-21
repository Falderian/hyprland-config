#!/usr/bin/env bash

ENV_PATH="${HOME}/.config/hypr/scripts/env.sh"
. $ENV_PATH

options="   Poweroff\n   Reboot\n   Suspend\n   Lock\n   Logout"

selected=$(echo -e "$options" | wofi --show=drun -I --conf "${CONFIG}" -i --dmenu | awk '{print tolower($2)}')

case $selected in
  poweroff)
    exec systemctl poweroff -i;;
  reboot)
    exec systemctl reboot;;
  suspend)
    exec systemctl suspend;;
  lock)
    hyprlock;;
  logout)
    hyprctl dispatch exit;;
esac