# This file launches utillitys, that do not depend
# on a running X session

[[ "$(tty)" = '/dev/tty1' && ! $(pidof Xorg) ]] || return

# Make sure that dbus is running properly, before launching pipewire
[[ $(which dbus-launch >/dev/null) && -z "$DBUS_SESSION_BUS_ADDRESS" ]] && \
   eval "$(dbus-launch --sh-syntax --exit-with-session)"

pipewire &!
pipewire-pulse &!
pipewire-media-session &!

# Start the X session using xinit wrapper
startx

