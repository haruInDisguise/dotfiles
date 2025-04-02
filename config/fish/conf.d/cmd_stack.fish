function cmd_stack_push
    set -l max_stack_size 8
    set -l stack_size (count $_cmd_stack_buffer)

    # fish discourages the usage of single argument variables for the test builtin.
    # see test(1)
    if test "$stack_size" -ge "$max_stack_size"
        # FIXME: Find a way to conditionally change vi mode ('bind -m' does not consider function status
        echo -e "\n\ncmd_stack: reached max stack size ($stack_size)"
        commandline --function repaint
        return -1
    end

    # Escape the input so we can get the stak size using 'count'
    set -l cmd (commandline --current-buffer | string escape --style=var)
    set -g -a _cmd_stack_buffer "$cmd"

    commandline --function clear-commandline
end

function cmd_stack_pop --on-event fish_postexec
    if test "$(count $_cmd_stack_buffer)" -le 0
        return
    end

    commandline --replace (string unescape --style=var $_cmd_stack_buffer[-1])
    set --erase _cmd_stack_buffer[-1]
end
