# Make sure that dbus is running properly, before launching pipewire
[[ $(which dbus-launch >/dev/null) && -z "$DBUS_SESSION_BUS_ADDRESS" ]] && \
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
