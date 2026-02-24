chmod +x setup.sh

./setup.sh
./setup.sh copy

./setup.sh link install

# Trocar o bash para fish
chsh -s /usr/bin/fish

# NVIDIA
sudo pacman -S linux-headers
sudo pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
