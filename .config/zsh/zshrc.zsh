#######################################################################################################################
# Plugins
#######################################################################################################################

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen apply

#######################################################################################################################
# Env
#######################################################################################################################

export GOPATH=$HOME/go

export PATH="$PATH:$HOME/.cargo/bin:$HOME/Scripts"

export LS_COLORS="$(vivid generate catppuccin-macchiato)"

#######################################################################################################################
# Aliases
#######################################################################################################################

alias ..='cd ..'
alias ....='cd ../..' 

alias sd='sudo'
alias dnf='sd dnf'
alias c='clear'
alias tp='trash-put'
alias vi='nvim'
alias b='batgrep'
alias man='batman'
alias sz='source ~/.zshrc'
alias copy='wl-copy'
alias paste='wl-paste'

alias g='git'
alias gs='git status -u'  
alias gb='git branch'  
alias ga='git add'
alias gaa='git add --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit '
alias gc!='git commit --amend'
alias gl='git pull origin'
alias glr='git pull --rebase origin'
alias gp='git push origin HEAD'
alias gp!='git push origin --force HEAD'

alias ls='eza --group-directories-first --icons=always'
alias l='ls'  
alias ll='ls -lA' 
alias la='ls -A' 
alias lu='eza -lA --icons=always --sort=size --total-size'
alias lz='eza -lA --icons=always --sort=time'

function lt () {
  eza --icons=always --tree --level=${1} ${@:2}
}

#######################################################################################################################
# FZF
#######################################################################################################################

# default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# catppuccin macchiato color scheme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

alias fs="rg-fzf.sh"

alias ff="fzf-tmux -p 90%,90% --ansi \
--delimiter : \
--preview 'bat --color=always {1}' \
--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
--bind 'enter:become(nohup wl-copy {}; echo copied \"{}\" to clipboard)'"

#######################################################################################################################
# Setup
#######################################################################################################################

autoload -Uz compinit && compinit -i

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY

HISTFILE=~/.history
HISTSIZE=100000
SAVEHIST=100000

#######################################################################################################################
# Init
#######################################################################################################################

source "$HOME/.cargo/env"

eval "$(starship init zsh)"

eval "$(atuin init zsh --disable-up-arrow)"

eval "$(zoxide init --cmd cd zsh)"
