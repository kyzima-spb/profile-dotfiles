#!/usr/bin/env bash
set -e

FONTS_DIR="$HOME/.local/share/fonts"
#SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

mkdir -p "$FONTS_DIR"
cd "$FONTS_DIR"

wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv

exit 0

