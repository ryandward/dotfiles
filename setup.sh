#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath "$0")")

# Create directories if they don't exist
mkdir -p ~/.config/nvim

# Backup and create symlinks
for file in .bash_profile .vimrc .zshrc .p10k.zsh init.vim; do
  target=~
  if [ "$file" == "init.vim" ]; then
    target=~/.config/nvim
  fi
  
  if [ -f "$target/$file" ]; then
    cp "$target/$file" "$DOTFILES_DIR/$file.bak"
  fi

  ln -sf $DOTFILES_DIR/$file $target/$file
done

# Backup GNOME Terminal settings
dconf dump /org/gnome/terminal/legacy/profiles:/ > "$DOTFILES_DIR/gnome-terminal-settings.dconf.bak"

# Load GNOME Terminal settings
dconf load /org/gnome/terminal/legacy/profiles:/ < $DOTFILES_DIR/gnome-terminal-settings.dconf

echo "Dotfiles and GNOME Terminal settings linked."

# Install Vim-Plug for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

