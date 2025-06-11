#! /usr/bin/env bash

mkdir -p "$HOME/.config/zed"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.local/share/applications"

mv "$HOME/.config/zed" "$HOME/.config/zed.bak"
mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"

ln -s "$(pwd)/zed" "$HOME/.config/zed"
ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
ln -s "$(pwd)/applications/discord-wayland.desktop" "$HOME/.local/share/applications/discord-wayland.desktop"
