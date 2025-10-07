{ pkgs, ... }:
{
  home.file = {
    ".config/kitty/kitty.conf".text = ''
      font_size 15
    '';
  };
}
