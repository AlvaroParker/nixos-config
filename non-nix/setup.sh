#! /usr/bin/env bash

mkdir -p "$HOME/.config/zed"
mkdir -p "$HOME/.config/nvim"

mv "$HOME/.config/zed" "$HOME/.config/zed.bak"
mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"

ln -s "$(pwd)/zed" "$HOME/.config/zed"
ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
