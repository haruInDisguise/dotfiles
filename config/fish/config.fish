# Taken from the default vi binding of 'escape'
function _key_handle_escape
    if commandline -P
        commandline -f cancel
    else
        set fish_bind_mode default
        if test (count (commandline --cut-at-cursor | tail -c2)) != 2
            commandline -f backward-char
        end
        commandline -f repaint-mode
    end
end

if status is-login
    source "$__fish_config_home/env.fish"
    exec bash -c '. /etc/profile; exec fish'
end

if status is-interactive
    set -g fish_greeting ''

    fish_vi_key_bindings

    bind ctrl-j -M replace _key_handle_escape
    bind ctrl-j -M insert -m default _key_handle_escape
    bind ctrl-j -m default _key_handle_escape

    bind -M replace_one -m default '' begin-selection kill-selection end-selection self-insert backward-char repaint-mode

    bind ctrl-e -M insert edit_command_buffer
    bind ctrl-e edit_command_buffer

    bind ctrl-n -M insert cmd_stack_push repaint
    bind ctrl-n cmd_stack_push repaint

    set fish_cursor_insert line
    set fish_cursor_default block
    set fish_cursor_visual block

    source "$__fish_config_dir/conf.d/alias.fish"
    source "$__fish_config_dir/conf.d/prompt.fish"
    source "$__fish_config_dir/conf.d/cmd_stack.fish"

    # ==============
    # External tools
    # ==============

    # zoxide:   Jump to directories
    # Source:   https://github.com/ajeetdsouza/zoxide
    command -q 'zoxide' && zoxide init fish | source

    # ast-grep: Structural code search
    # Source:   https://github.com/ast-grep/ast-grep
    command -q 'ast-grep' && ast-grep completions fish | source

    # fzf-plugin: fzf goodness for fish
    # Source:   https://github.com/PatrickF1/fzf.fish
    set -a fish_function_path "$__fish_config_dir/extern/fzf.fish/functions"
    set -a fish_complete_path "$__fish_config_dir/extern/fzf.fish/completions"
    source "$__fish_config_dir/extern/fzf.fish/conf.d/fzf.fish"
end
