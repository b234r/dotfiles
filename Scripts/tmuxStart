#!/bin/bash

if [[ $(tmux list-sessions 2> /dev/null | rg main) ]]; then
	tmux a -t main
else
	tmux new-session -s main 'fortune | cowsay -r -W 100 | lolcat -r -f; exec zsh'
fi

