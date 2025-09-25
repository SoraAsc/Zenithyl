{ pkgs, ... }:
{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable =  true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
    };
  };
}
