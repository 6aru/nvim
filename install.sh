#!/usr/bin/env bash

set -e

echo "Installing dependencies..."

sudo apt update

sudo apt install -y \
git \
curl \
wget \
ripgrep \
fd-find \
fzf \
nodejs \
npm \
unzip

mkdir -p ~/.config

echo "Installing Neovim config..."

cp -r nvim ~/.config/

echo "Creating i3 theme state..."

mkdir -p ~/.config/i3

if [ ! -f ~/.config/i3/.current_theme ]; then
    echo "gruvbox" > ~/.config/i3/.current_theme
fi

echo
echo "Installation complete."
echo
echo "Launch with:"
echo
echo "    nvim"
