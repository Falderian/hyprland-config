CURRENT=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$CURRENT" == "'prefer-dark'" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    notify-send "System Theme" "Activating light mode" -i weather-clear
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    notify-send "System Theme" "Activating dark mode" -i weather-clear-night
fi
