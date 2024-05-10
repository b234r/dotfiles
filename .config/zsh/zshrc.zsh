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

bindkey -e

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

export LS_COLORS="$(vivid generate rose-pine-moon)"

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
# Init
#######################################################################################################################

source "$HOME/.config/zsh/fzf.zsh"

source "$HOME/.cargo/env"

eval "$(starship init zsh)"

eval "$(atuin init zsh --disable-up-arrow)"

eval "$(zoxide init --cmd cd zsh)"
