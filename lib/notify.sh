# Some useful functions for working with notifications
# To be sourced

if [ -z "$_DOTFILES_NOTIFY_SH_" ]; then
    _DOTFILES_NOTIFY_SH_=1

    NOTIFY_CMD="notify-send"

    notify_evoke() {
        #notify_send_value="${notify_send_value:-$(notify-send -p $@)}"
        eval "$NOTIFY_CMD" $@
    }

    notify_evoke hello world
    notify_evoke hello world
fi
