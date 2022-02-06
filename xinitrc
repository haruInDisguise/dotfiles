# Lauch things ... thats it. nice

# Some mobile/desktop specific stuff
case "$(uname -n)" in
    'artbox' )
        xrandr --output DP-2 --primary --auto --left-of DVI-D-0 & ;;
    'mobile_box' )
        setxkbmap -option caps:escape & ;;
esac

redshift -l "${REDSHIFT_LOCATION}" &

# Scripts...
xorg_set_background &
xorg_input_configure_touchpad &

# huh...
unclutter --ignore-scrolling --timeout 5 &
dunst &

exec dwm
#exec $HOME/projects/coding/rust/penrose_config/target/release/penrose_client
