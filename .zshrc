# Powerlevel10k Instant 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Global Settings 
export PATH=$PATH:/home/ryandward/.local/bin
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
export VISUAL='nvim'

# Pyenv Setting 
eval "$(pyenv init --path)"

# History settings
setopt HIST_IGNORE_SPACE
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Plugins
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete web-search pyenv pyvenv-activate)
plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete web-search pyenv pyvenv-activate)


# Zsh and Theme #
export ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
pyvenv_auto_activate_enable

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

command -v lsd > /dev/null && alias ls='lsd --group-dirs first'
command -v lsd > /dev/null && alias tree='lsd --tree'

# Tools
## Conda initialization
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

# ## Load Zsh-syntax-highlighting if available
# if [ -e "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
#   source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# fi

# ## Load Zsh-autosuggestions if available
# if [ -e "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
#   source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
# fi

## Set up case-insensitive and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

## Broot
source /home/ryandward/.config/broot/launcher/bash/br

## Function to leave header at the top when performing various operations
body() {
    IFS= read -r header
    printf '%s\n' "$header"
    "$@"
}


## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh