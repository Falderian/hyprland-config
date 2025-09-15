#!/usr/bin/env bash


## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5


# Current Theme
dir="$HOME/.config/rofi/powermenu/type-5"
theme='style-1'


# CMDs
lastlogin="$(last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7)"
uptime="$(uptime | sed -e 's/up //g')"
host=$(hostname)


# Options
shutdown=''
reboot='󰜉'
lock='󰌾'
suspend='󰤄'
logout='󰗽'
# yes and no больше не нужны


# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p " $USER@$host" \
        -mesg "󰍂 Last Login: $lastlogin 
 󱑂 Uptime: $uptime" \
        -theme ${dir}/${theme}.rasi
}


# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$suspend\n$shutdown\n$reboot\n$lock\n$logout" | rofi_cmd
}


# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        hyprlock -c ~/.config/hyprlock/hyprlock.conf 
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        hyprctl dispatch exit || pkill hyprland
        ;;
esac
