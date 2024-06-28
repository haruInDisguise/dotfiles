# Make sure that dbus is running properly, before launching pipewire
[[ $(which dbus-launch >/dev/null) && -z "$DBUS_SESSION_BUS_ADDRESS" ]] && \
   eval "$(dbus-launch --sh-syntax --exit-with-session)"

# Launch wayland/the river wm
CACHE_PATH="$XDG_CACHE_HOME/river"
mkdir -p "$CACHE_PATH"
river -log-level info >"$CACHE_PATH/all.log" 2>&1
