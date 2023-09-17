#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath "$0")")

# Create directories if they don't exist
mkdir -p ~/.config/nvim

# Create symlinks
ln -sf $DOTFILES_DIR/.bash_profile ~/.bash_profile
ln -sf $DOTFILES_DIR/.vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/init.vim ~/.config/nvim/init.vim

# Load GNOME Terminal settings
dconf load /org/gnome/terminal/legacy/profiles:/ < $DOTFILES_DIR/gnome-terminal-settings.dconf

echo "Dotfiles and GNOME Terminal settings linked."

