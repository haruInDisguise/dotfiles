# Wrapper for 'man'. Properly align display in narrow windows
# TODO: This might become an alias...
man() MANWIDTH="$COLUMNS" command -p man "$@"

# TODO: Write a proper implementation
kbmap() command -p setxkbmap "$1" -option caps:escape

