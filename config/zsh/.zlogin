# This file launches utillitys, that do not depend
# on a running X session

if [[ "$(tty)" = '/dev/tty1' && ! $(pidof Xorg) ]]; then
    # Make sure that dbus is running properly, before launching pipewire
    if [[ $(which dbus-launch >/dev/null) && -z "$DBUS_SESSION_BUS_ADDRESS" ]]; then
       eval "$(dbus-launch --sh-syntax --exit-with-session)"
    fi

    pipewire &!
    pipewire-media-session &!
    pipewire-pulse &!

    # Start the X session using xinit
    startx
fi

