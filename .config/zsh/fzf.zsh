#######################################################################################################################
# FZF Config
#######################################################################################################################

# use tmux window by default
export FZF_TMUX=1
# make it a popup
export FZF_TMUX_OPTS='-p90%,90%' 

# default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# rose pine moon color scheme
export FZF_DEFAULT_OPTS="
--color=fg:#908caa,bg:#232136,hl:#ea9a97
--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
--color=border:#e0def4,header:#3e8fb0,gutter:#232136
--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
--border='sharp' --border-label='' --preview-window='sharp' --prompt='> '
--marker='>' --pointer='◆' --separator='─' --scrollbar='│'"

#######################################################################################################################
# fzf-tab
#######################################################################################################################

# use popup for tab completion
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

zstyle ":fzf-tab:*" fzf-flags --color=fg:#908caa,bg:#232136,hl:#ea9a97 \
--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97 \
--color=border:#44415a,header:#3e8fb0,gutter:#232136 \
--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a \
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa

#######################################################################################################################
# aliases
#######################################################################################################################

alias fs="rg-fzf.sh"

alias ff="fzf-tmux -p 90%,90% --ansi \
--delimiter : \
--preview 'bat --color=always {1}' \
--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
--bind 'enter:become(nohup wl-copy {}; echo copied \"{}\" to clipboard)'"
