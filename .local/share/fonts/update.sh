#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"

wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -d JetBrainsMono -o JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv

exit 0

