#!/usr/bin/env bash

ENV_PATH="${HOME}/.config/hypr/scripts/env.sh"
. $ENV_PATH

CONFIG="${HOME}/.config/wofi/config"

# Launch Wofi with icons while keeping the GTK theme
wofi --show=drun -I --conf "${CONFIG}"
