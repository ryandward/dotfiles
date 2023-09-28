# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
export VISUAL='nvim'

ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# History settings
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Key bindings
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ll='ls -l'
alias c='clear'
alias la='ls -a'
alias lla='ls -la'
alias awk='awk -v FS="\t" -v OFS="\t"'
alias tabulate='tabulate -s "\t"'
alias vim=nvim
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'# Add more plugins
command -v lsd > /dev/null && alias ls='lsd --group-dirs first'
command -v lsd > /dev/null && alias tree='lsd --tree'

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search pipenv pyenv)


# Conda initialization
__conda_setup="$('/home/ryandward/miniconda3/condabin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ryandward/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ryandward/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ryandward/miniconda3/condabin:$PATH"
    fi
fi
unset __conda_setup

# Load Zsh-syntax-highlighting if available
if [ -e "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Load Zsh-autosuggestions if available
if [ -e "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Set up case-insensitive and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

source /home/ryandward/.config/broot/launcher/bash/br

# function to leave header at the top when performing various operations
body() {
    IFS= read -r header
    printf '%s\n' "$header"
    "$@"
}

export PATH=$PATH:/home/ryandward/.local/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
