#!/usr/bin/sh

SESSION_NAME="dev-pad"

if ! tmux has-session -t "$SESSION_NAME" > /dev/null 2>&1; then
    tmux new-session -s "$SESSION_NAME" -d
    tmux new-window -t "$SESSION_NAME"
    tmux new-window -t "$SESSION_NAME"
    tmux select-window -t "${SESSION_NAME}:1"
    tmux select-window -t "${SESSION_NAME}:0"
fi

exec tmux attach -t "$SESSION_NAME"
