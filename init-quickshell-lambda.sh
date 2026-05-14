# Initialize QuickShell Lambda theme and caches
# This script sets up the necessary cache files and generates initial colors

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAMBDA_CONFIG="$HOME/.config/quickshell/lambda"
APPLY_THEME_SCRIPT="$LAMBDA_CONFIG/scripts/apply-theme.sh"
WALLPAPER_DIR="$LAMBDA_CONFIG/assets/themes"
THEMES_DEFAULT="$LAMBDA_CONFIG/assets/themes.default.json"
THEMES_CUSTOM="$LAMBDA_CONFIG/assets/themes.json"

# Find first available wallpaper
WALLPAPER=$(ls "$WALLPAPER_DIR"/*.png 2>/dev/null | head -1)

if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

echo "Initializing QuickShell Lambda..."
echo "Using wallpaper: $(basename "$WALLPAPER")"

# Create cache directories
mkdir -p "$HOME/.cache/matugen"
mkdir -p "$HOME/.cache/lambda"

# Create themes.json from themes.default.json if it doesn't exist
if [ ! -f "$THEMES_CUSTOM" ] && [ -f "$THEMES_DEFAULT" ]; then
    echo "Creating themes.json from default..."
    cp "$THEMES_DEFAULT" "$THEMES_CUSTOM"
fi

# Run apply-theme script to initialize colors and theme index
if [ ! -f "$APPLY_THEME_SCRIPT" ]; then
    echo "Error: apply-theme.sh not found at $APPLY_THEME_SCRIPT"
    exit 1
fi

echo "Generating colors with matugen..."
bash "$APPLY_THEME_SCRIPT" "$WALLPAPER" 0

# Verify files were created
echo ""
echo "Verification:"
[ -f "$HOME/.cache/matugen/colors.json" ] && echo "  [OK] colors.json created" || echo "  [FAIL] colors.json NOT created"
[ -f "$HOME/.cache/lambda/theme_index" ] && echo "  [OK] theme_index created" || echo "  [FAIL] theme_index NOT created"
[ -f "$THEMES_CUSTOM" ] && echo "  [OK] themes.json created" || echo "  [FAIL] themes.json NOT created"

# Display generated colors (first few lines)
if [ -f "$HOME/.cache/matugen/colors.json" ]; then
    echo ""
    echo "Generated color palette:"
    head -20 "$HOME/.cache/matugen/colors.json"
fi

echo ""
echo "QuickShell Lambda initialized successfully!"
echo "You can now:"
echo "   1. Restart quickshell: killall qs && qs -c lambda"
echo "   2. Or just reload the theme selector in the UI"
