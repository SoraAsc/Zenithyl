sudo pacman -Syu --needed - < requirements/hypr-packages.txt
sudo pacman -Syu --needed - < requirements/packages.txt

while read pkg; do
  yay -S --noconfirm "$pkg"
done < requirements/aur.txt