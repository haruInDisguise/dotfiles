if status is-login
    source "$__fish_config_home/env.fish"
    exec bash -c '. /etc/profile; exec fish'
end

if status is-interactive
    # No greeting :(
    set -g fish_greeting ''

    # Vi Mode
    fish_vi_key_bindings

    bind ctrl-j -M insert -m default cancel
    bind ctrl-j -m default cancel

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
