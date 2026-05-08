#!/usr/bin/env bash

WALLPAPER_PATH="$1"
MATUGEN_OUTPUT="$HOME/.cache/matugen/colors.json"

# LOG file for debugging
LOG_FILE="/tmp/lambda-theme.log"
echo "--- $(date) ---" > "$LOG_FILE"
echo "Wallpaper: $WALLPAPER_PATH" >> "$LOG_FILE"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "Usage: $0 <wallpaper_path>"
    exit 1
fi

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper file not found: $WALLPAPER_PATH" >> "$LOG_FILE"
    exit 1
fi

mkdir -p "$(dirname "$MATUGEN_OUTPUT")"

# 1. Update wallpaper live using awww
if command -v awww &> /dev/null; then
    echo "Applying wallpaper with awww..." >> "$LOG_FILE"
    awww img "$WALLPAPER_PATH" --transition-type any >> "$LOG_FILE" 2>&1
fi

# 2. Generate colors with matugen
if command -v matugen &> /dev/null; then
    echo "Generating colors with matugen..." >> "$LOG_FILE"
    TEMP_JSON=$(mktemp)
    if matugen image "$WALLPAPER_PATH" -m dark --prefer=saturation --json hex > "$TEMP_JSON" 2>> "$LOG_FILE"; then
        mv "$TEMP_JSON" "$MATUGEN_OUTPUT"
        echo "Colors generated successfully." >> "$LOG_FILE"
    else
        echo "Matugen failed. Check $LOG_FILE" >> "$LOG_FILE"
        rm -f "$TEMP_JSON"
    fi
fi
