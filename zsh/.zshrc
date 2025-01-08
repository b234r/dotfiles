#######################################################################################################################
# Env
#######################################################################################################################

export GOPATH=$HOME/go

export PATH="$PATH:$HOME/.cargo/bin:$HOME/Scripts:$HOME/.local/bin:$GOPATH/bin"

export LS_COLORS="$(vivid generate tokyonight-night)"

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
alias cat='bat'
alias b='batgrep'
alias man='batman'
alias sz='source ~/.zshrc'
alias copy='wl-copy'
alias paste='wl-paste'
alias rm='rm -i'

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

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

alias fs="rg-fzf.sh"

alias ff="fzf-tmux -p 90%,90% --ansi \
--delimiter : \
--preview 'bat --color=always {1}' \
--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
--bind 'enter:become(nohup wl-copy {}; echo copied \"{}\" to clipboard)'"

#######################################################################################################################
# Setup
#######################################################################################################################

#autoload -Uz compinit && compinit -i

#setopt SHARE_HISTORY
#setopt HIST_EXPIRE_DUPS_FIRST
#setopt APPEND_HISTORY

#HISTFILE=~/.history
#HISTSIZE=100000
#SAVEHIST=100000

#######################################################################################################################
# Plugins
#######################################################################################################################

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

antigen bundle Aloxaf/fzf-tab
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen apply

#######################################################################################################################
# Init
#######################################################################################################################

source "$HOME/.cargo/env"

eval "$(starship init zsh)"

eval "$(atuin init zsh --disable-up-arrow)"

eval "$(zoxide init zsh --cmd cd)"

if [ -z $TMUX ]; then
  WS='ws'$(xdotool get_desktop)
  if [[ $(tmux list-sessions 2> /dev/null | rg $WS) ]]; then
    tmux a -t $WS
  else
    tmux new-session -s $WS 'fortune | cowsay -r -W 100 | lolcat -r -f; exec zsh'
  fi
fi

