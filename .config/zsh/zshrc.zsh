#######################################################################################################################
# Setup
#######################################################################################################################

autoload -U compinit && compinit

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY

HISTFILE=~/.history
HISTSIZE=100000
SAVEHIST=100000

bindkey -e

#######################################################################################################################
# Env
#######################################################################################################################

export GOPATH=$HOME/go

export PATH="$PATH:$HOME/.cargo/bin:$HOME/Scripts"

#######################################################################################################################
# Init
#######################################################################################################################


source "$HOME/.cargo/env"

