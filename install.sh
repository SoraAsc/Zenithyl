#sudo pacman -Syu --needed - < requirements/hypr-packages.txt
#sudo pacman -Syu --needed - < requirements/packages.txt
while read -r pkg; do
  sudo pacman -S --needed --noconfirm "$pkg"
done < requirements/hypr-packages.txt

while read -r pkg; do
  sudo pacman -S --needed --noconfirm "$pkg"
done < requirements/packages.txt


while read -r pkg; do
  yay -S --needed --noconfirm "$pkg"
done < requirements/aur.txt

yay -S --needed quickshell
