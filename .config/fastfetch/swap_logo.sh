DIR="$HOME/.config/fastfetch/images"
TARGET="$HOME/.config/fastfetch/current.png"

IMG=$(find "$DIR" -type f | shuf -n 1)

ln -sf "$IMG" "$TARGET"
