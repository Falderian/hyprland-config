#!/bin/bash

# Define source and destination paths
SRC_DIR="$HOME/.config"
DEST_DIR="$HOME/config-backup"
PKG_LIST=("dunst" "htop" "hyprland" "kitty" "ml4w" "wofi" "waybar" "starship" "gtk3" "nwg-look" "xsettingsd" "yazi")

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

# Install required packages
echo "Installing required packages..."
yay -S --needed "${PKG_LIST[@]}"

echo "Copying configuration files..."
mkdir -p "$DEST_DIR"
rsync -av --exclude="*cache*" --exclude="*tmp*" "$SRC_DIR/" "$DEST_DIR/"

echo "Setup complete. All packages installed and configurations backed up to $DEST_DIR."

