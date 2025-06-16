#! /usr/bin/env bash

mkdir -p "$HOME/.config/zed"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/Code/User"

mv "$HOME/.config/zed" "$HOME/.config/zed.bak"
mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"

ln -s "$(pwd)/zed" "$HOME/.config/zed"
ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
ln -s "$(pwd)/vscode/keybinds.json" "$HOME/.config/Code/User/keybinds.json"
ln -s "$(pwd)/vscode/settings.json" "$HOME/.config/Code/User/settings.json"
