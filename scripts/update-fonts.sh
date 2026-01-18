#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
FONTS_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONTS_DIR"
cd "$FONTS_DIR"

sudo cp -r "$SCRIPT_DIR"/fonts/* /usr/local/share/fonts/

wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip

fc-cache -fv

exit 0

