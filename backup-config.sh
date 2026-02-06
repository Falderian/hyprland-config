#!/usr/bin/env bash

REPO_PATH="$HOME/Templates/hyprland-config"
CONFIG_ENTRIES=("helix" "swaync" "hyprlock" "hypr" "kitty" "ml4w" "rofi" "waybar" "starship.toml" "swaync")

echo "Syncing configurations to Git repository..."

for entry in "${CONFIG_ENTRIES[@]}"; do
  SRC_PATH="$HOME/.config/$entry"
  DEST_PATH="$REPO_PATH/$entry"

  if [[ -d "$SRC_PATH" ]]; then
    mkdir -p "$DEST_PATH"
    rsync -a --delete "$SRC_PATH/" "$DEST_PATH/"
  elif [[ -f "$SRC_PATH" ]]; then
    mkdir -p "$(dirname "$DEST_PATH")"
    rsync -a "$SRC_PATH" "$DEST_PATH"
  fi
done

cp /etc/nixos/configuration.nix .

cd "$REPO_PATH" || { echo "Error: Unable to access $REPO_PATH"; exit 1; }

git add .

timestamp=$(date '+%Y-%m-%d %H:%M:%S')

git commit -m "$timestamp"

git push

echo "Configurations synced and pushed successfully."
