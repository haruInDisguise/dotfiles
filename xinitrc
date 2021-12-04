# Lauch things, that require a running
# X session

redshift -l "${REDSHIFT_LOCATION}" &

# Scripts...
xorg_set_background &
xorg_input_configure_touchpad &

setxkbmap -option caps:escape &
unclutter --ignore-scrolling --timeout 5 &
dunst &

exec dwm
#$XDG_DATA_HOME/../src/wtftw/target/release/wtftw
