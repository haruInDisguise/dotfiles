# Make sure that dbus is running properly, before launching pipewire
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

pipewire &

# Scripts...
xorg_launch_redshift &
xorg_set_background &
xorg_input_configure_touchpad &

setxkbmap -option caps:escape &
unclutter --ignore-scrolling --timeout 5 &

exec dwm
#$XDG_DATA_HOME/../src/wtftw/target/release/wtftw
