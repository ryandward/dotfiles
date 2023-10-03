#!/bin/bash

# Define the plugin URLs and target directories
plugins=("https://github.com/zsh-users/zsh-autosuggestions.git" "https://github.com/zsh-users/zsh-syntax-highlighting.git" "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" "https://github.com/marlonrichert/zsh-autocomplete.git")
target_dirs=("$ZSH_CUSTOM/plugins/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" "$ZSH_CUSTOM/plugins/zsh-autocomplete")

# Loop through the plugins and perform the appropriate action
for ((i=0; i<${#plugins[@]}; i++)); do
    url="${plugins[i]}"
    dir="${target_dirs[i]}"
    
    if [ -d "$dir" ]; then
        # Directory exists, perform git pull
        echo "Updating $dir..."
        cd "$dir" || exit
        git pull
        cd - >/dev/null || exit
    else
        # Directory doesn't exist, clone the repository
        git clone --depth 1 -- "$url" "$dir"
    fi
done

