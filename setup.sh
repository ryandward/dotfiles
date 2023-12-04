#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

DOTFILES_DIR=$(dirname "$(realpath "$0")")

# Create directories if they don't exist
mkdir -p "$HOME/.config/nvim"

# Function to backup and create symlink
create_symlink() {
    local file="$1"
    local target_dir="$2"
    local backup_dir="$3"

    if [ -f "$target_dir/$file" ]; then
        cp "$target_dir/$file" "$backup_dir/$file.bak"
    fi

    ln -sf "$backup_dir/$file" "$target_dir/$file"
}

# Backup and create symlinks
for file in .bash_profile .vimrc .zshrc .p10k.zsh .dircolors; do
    target="$HOME"
    [ "$file" == "init.vim" ] && target="$HOME/.config/nvim"
    create_symlink "$file" "$target" "$DOTFILES_DIR"
done

# Backup and load GNOME Terminal settings
if command_exists dconf; then
    dconf dump /org/gnome/terminal/legacy/profiles:/ > "$DOTFILES_DIR/gnome-terminal-settings.dconf.bak"
    dconf load /org/gnome/terminal/legacy/profiles:/ < "$DOTFILES_DIR/gnome-terminal-settings.dconf"
else
    echo "dconf command not found. Skipping GNOME Terminal settings backup and load."
fi

echo "Dotfiles and GNOME Terminal settings linked."

# Install Vim-Plug for Neovim
if command_exists curl; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
    echo "curl command not found. Skipping Vim-Plug installation."
fi
