eval "$(dircolors ~/.dircolors)"

# Powerlevel10k Instant 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Global Settings 
export PATH=$PATH:/home/ryandward/.local/bin
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh
export EDITOR='/usr/bin/code-insiders'
export VISUAL='/usr/bin/code-insiders'

# Pyenv Setting 
eval "$(pyenv init --path)"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# History settings
setopt HIST_IGNORE_ALL_DUPS
# setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY  
setopt INC_APPEND_HISTORY
HISTSIZE=1000000
SAVEHIST=1000000

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Plugins
# plugins=(git zsh-autosuggestions zsh-autocomplete fzf-tab fast-syntax-highlighting web-search pyenv pyvenv-activate)
plugins=(git zsh-autosuggestions zsh-autocomplete fast-syntax-highlighting web-search pyenv pyvenv-activate)
# plugins=(git zsh-autosuggestions zsh-autocomplete web-search pyenv pyvenv-activate)
# unused plugins: zsh-syntax-highlighting, f
# Additional Zsh Optimizations
# Command correction
setopt CORRECT

# Auto-CD
setopt AUTO_CD

# Zsh and Theme #
export ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
pyvenv_auto_activate_enable


# FZF integration
# export FZF_DEFAULT_OPTS='--extended --ansi --cycle --border --inline-info --height 40% --preview "bat --color=always --style=header,grid --line-range :500 {}" --preview-window down:1:hidden:wrap --bind ctrl-f:page-down,ctrl-b:page-up,ctrl-a:toggle-all,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-r:toggle-sort,ctrl-t:toggle-preview,ctrl-s:toggle-sort,ctrl-z:ignore,ctrl-q:abort'
# export FZF_DEFAULT_OPTS='--extended --cycle --border --inline-info --height 40% --preview "bat --color=always --style=header,grid --line-range :500 {}" --preview-window down:1:hidden:wrap --bind ctrl-f:page-down,ctrl-b:page-up,ctrl-a:toggle-all,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-r:toggle-sort,ctrl-t:toggle-preview,ctrl-s:toggle-sort,ctrl-z:ignore,ctrl-q:abort'
export FZF_DEFAULT_OPTS='--extended --border --height 40% --preview "vim'
# FZF key bindings

source ~/.config/completion.zsh
source ~/.config/key-bindings.zsh
bindkey -r '^R'
bindkey '^R' fzf-history-widget
bindkey '\et' fzf-file-widget  # Alt+T
# bindkey '\er' fzf-history-widget  # Alt+R
bindkey '\ec' fzf-cd-widget  # Alt+C
# zle -D up-line-or-search
# bindkey "${terminfo[kcuu1]}" fzf-autocomplete # Up arrow

zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' continuous-trigger '/'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -t --group-dirs=first --tree --depth=2 --color=always --icon=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
#bindkey "${terminfo[kcuu1]}" fzf-autocomplete-widget

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

# Set up case-insensitive and substring completion
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
 
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

function ccd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi

    while true; do
        local lsdir=$(echo ".." && lsd -F --color=always --icon=always | grep '/$')
        local selection="$(printf '%s\n' "${lsdir[@]}" |
            fzf --ansi --reverse --expect=tab,ctrl-m --preview '
                __cd_nxt="$(echo {} | sed "s/^[^ ]* //")";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                lsd -t --group-dirs=first --tree --depth=2 --color=always --icon=never "${__cd_path}";
        ')"
        
        local key=$(head -1 <<< "$selection")
        local dir=$(tail -1 <<< "$selection")

        if [[ $key == 'ctrl-m' ]]; then
            builtin cd "$(echo $dir | sed 's/^[^ ]* //')" &> /dev/null
            return
        elif [[ $key != 'tab' ]]; then
            return
        fi

        builtin cd "$(echo $dir | sed 's/^[^ ]* //')" &> /dev/null
    done
}

disable r
