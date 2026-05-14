MODE="${1:-link}" #"link" # "copy" to copy, "link" to create symlink

FOLDERS=(
  "./.config/quickshell/lambda"
  "./.config/fish"
  "./.config/kitty"
  "./.config/fastfetch"
  "./.config/nvim"
  "./.config/hypr"
)

BASE_CONFIG="$HOME/.config"

for FOLDER in "${FOLDERS[@]}"; do
  if [ ! -d "$FOLDER" ]; then
    echo "Folder '$FOLDER' not found, skipping..."
    continue
  fi

  RELATIVE_PATH="${FOLDER#./.config/}"
  DEST="$BASE_CONFIG/$RELATIVE_PATH"

  if [ "$MODE" = "copy" ]; then
    mkdir -p "$DEST"
    cp -rn "$FOLDER/"* "$DEST/"
    echo "Contents of '$FOLDER' copied to '$DEST'"
  elif [ "$MODE" = "link" ]; then
    PARENT_DIR=$(dirname "$DEST")
    mkdir -p "$PARENT_DIR"
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
      rm -rf "$DEST"
    fi
    ln -s "$PWD/$FOLDER" "$DEST"
    echo "Folder '$FOLDER' linked to '$DEST'"
  else
    echo "Invalid MODE: $MODE"
    exit 1
  fi
done
