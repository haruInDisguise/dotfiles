# Launch/Attach to tmux and setup a basic session
# To be sourced by a (somewhat) POSIX compliant shell.

SESSION_NAME='dev'

tmux list-sessions && exec tmux attach

tmux new-session -s "${SESSION_NAME}" -d
tmux new-window -t "${SESSION_NAME}"
tmux new-window -t "${SESSION_NAME}"
tmux select-window -t "${SESSION_NAME}:1"
tmux select-window -t "${SESSION_NAME}:0"

exec tmux attach -t "${SESSION_NAME}"
