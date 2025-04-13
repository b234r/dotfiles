#######################################################################################################################
# Env
#######################################################################################################################

export GOPATH=$HOME/go

export NODE_PATH=$(npm root -g)

export PATH="$PATH:/usr/local/WordNet-3.0/bin:$HOME/.cargo/bin:$HOME/Scripts:$HOME/.local/bin:$GOPATH/bin"

export LS_COLORS="$(vivid generate catppuccin-mocha)"

# https://github.com/jesseduffield/lazydocker/issues/4
export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

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
alias docker='podman'
alias ld='lazydocker'

alias lg='lazygit'
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
--border=rounded
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"


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
  c=$(wmctrl -d 2> /dev/null | grep \* | awk '{print $1;}')
  ws="ws${c:-0}"
  if [[ $(tmux list-sessions 2> /dev/null | rg $ws) ]]; then
    tmux a -t $ws
  else
    tmux new-session -s $ws 'fortune | cowsay -r -W 80 | lolcat -r -f; exec zsh'
  fi
fi
export PATH="/home/john/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/john/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
