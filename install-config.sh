#!/bin/bash

# Define repo path and config directories
REPO_PATH="./"
CONFIG_ENTRIES=("swaync" "htop" "hypr" "foot" "ml4w" "wofi" "waybar" "starship.toml" "gtk-3.0" "nwg-look" "xsettingsd")

# Define required packages
PKG_LIST=("swaync" "htop" "hyprland" "foot" "wofi" "waybar" "starship" "gtk3" "nwg-look" "xsettingsd")

echo "Starting setup..."

# Check if yay is installed
if ! command -v yay &> /dev/null; then
  echo "yay is not installed. Installing yay..."
  sudo pacman -S --needed base-devel git
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay || exit 1
  makepkg -si
  cd - || exit 1
  rm -rf /tmp/yay
fi

# Install required packages (with confirmation)
echo "Installing required packages..."
yay -S --noconfirm --needed "${PKG_LIST[@]}"

# Copy config files from the repo to ~/.config/
echo "Restoring configuration files from $REPO_PATH to ~/.config/"

for entry in "${CONFIG_ENTRIES[@]}"; do
  SRC_PATH="$REPO_PATH/$entry"
  DEST_PATH="$HOME/.config/$entry"

  if [[ -d "$SRC_PATH" ]]; then
    mkdir -p "$DEST_PATH"
    rsync -a --delete "$SRC_PATH/" "$DEST_PATH/"
  elif [[ -f "$SRC_PATH" ]]; then
    mkdir -p "$(dirname "$DEST_PATH")"
    rsync -a "$SRC_PATH" "$DEST_PATH"
  fi
done

echo "All configuration files restored successfully."

echo "Setup complete!"
