CURRENT=$(gsettings get org.gnome.desktop.interface gtk-theme)

# Theme names (change these if you use different variants)
LIGHT_THEME="Fluent-red-Light-compact"
DARK_THEME="Fluent-red-Dark-compact"

if [[ "$CURRENT" == "'Fluent-red-Dark-compact'" ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_THEME"
    notify-sednd "GTK Theme" "Activating light theme" -i weather-clear
else
    gsettings set org.gnome.desktop.interface gtk-theme "$DARK_THEME"
    notify-send "GTK Theme" "Activating dark theme" -i weather-clear-night
fi