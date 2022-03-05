#!/usr/bin/zsh

# Launch the default tmux session
SESSION_NAME='dev'

if [[ $(tmux list-sessions) > 0  ]]; then
    exec tmux attach
fi

tmux start-server
tmux new -s "${SESSION_NAME}" -d
tiux new-window -t "${SESSION_NAME}"
tmux select-window -t "${SESSION_NAME}:0"

exec tmux attach -t "${SESSION_NAME}"
