# Quickly switch kbmap, while preserving xkb config
# TODO: Write a proper implementation...
kbmap() command -p setxkbmap "${1:?error: missing keymap argument}" -option caps:escape

