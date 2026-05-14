# Zenithyl - Hyprland Environment Setup

## Installation Process

### Prerequisites
- Arch Linux-based system
- Root access (sudo)
- AUR package manager installed (yay recommended)

### Installation Steps

1. **Clone or download the repository:**
   ```
   git clone <repo-url> Zenithyl
   cd Zenithyl
   ```

2. **Make scripts executable:**
   ```
   chmod +x setup.sh
   chmod +x install.sh
   chmod +x link_folders.sh
   ```

3. **Run the full installation:**
   ```
   ./setup.sh link install
   ```
   - This will install all necessary packages and create symlinks for configuration files.

   Alternatives:
   - `./setup.sh copy install`: Copies files instead of creating symlinks.
   - `./setup.sh link`: Only creates symlinks (assumes packages are already installed).
   - `./setup.sh copy`: Only copies files.

4. **Additional configurations:**

   - **Change shell to fish:**
     ```
     chsh -s /usr/bin/fish
     ```
     Restart the terminal or logout/login.

   - **NVIDIA drivers (if applicable):**
     ```
     sudo pacman -S linux-headers
     sudo pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
     ```

   - **QuickShell Lambda initialization:**
     ```
     ./init-quickshell-lambda.sh
     ```
     This script initializes the color cache and theme index required by QuickShell Lambda. Run this after the main installation.

## Requirements Analysis
The files in `requirements/` contain lists of packages to install:
- `packages.txt`: Official Arch packages (kitty, neovim, etc.)
- `hypr-packages.txt`: Hyprland-related packages
- `aur.txt`: AUR packages (wlogout, qview, vivaldi)

### Potential Issues and Solutions
- **Packages not found:** Ensure the system is updated (`sudo pacman -Syu`). AUR packages may change; use `yay -Ss <package>` to check.
- **yay not installed:** Install it from the AUR:

   ```bash
   sudo pacman -S --needed base-devel git
   git clone https://aur.archlinux.org/yay.git
   cd yay
   makepkg -si
   ```
- **Installation errors:** The script continues even if a package fails. Check logs and reinstall manually if needed.
- **Permissions:** Run as a user with sudo access.

## QuickShell Lambda Configuration

If QuickShell Lambda is not displaying components or showing warnings about missing theme files:

1. **Run the initialization script:**
   ```bash
   ./init-quickshell-lambda.sh
   ```

2. **Restart QuickShell:**
   ```bash
   killall qs && qs -c lambda
   ```
