INSTALL_SCRIPT="./install.sh"
MOVER_SCRIPT="./link_folders.sh"

MODE="${1:-link}"  # ex: ./setup.sh copy or ./setup.sh link
INSTALL="${2:-noinstall}" # ex: ./setup.sh link install or ./setup.sh link noinstall

if [ "$INSTALL" = "install" ]; then
  if [ ! -f "$INSTALL_SCRIPT" ]; then
    echo "Error: '$INSTALL_SCRIPT' not found!"
    exit 1
  fi
  echo "Running install.sh..."
  bash "$INSTALL_SCRIPT"
  echo "Installation script completed."
else
  echo "Skipping installation."
fi

if [ ! -f "$MOVER_SCRIPT" ]; then
  echo "Error: '$MOVER_SCRIPT' not found!"
  exit 1
fi


echo "Linking folders..."
bash "$MOVER_SCRIPT" "$MODE"
echo "Folders linked successfully."

# Initialize QuickShell Lambda if requested
if [ "$INSTALL" = "install" ]; then
  if [ -f "./init-quickshell-lambda.sh" ]; then
    echo ""
    echo "Initializing QuickShell Lambda..."
    bash "./init-quickshell-lambda.sh"
  fi
fi

echo "Setup complete!"
