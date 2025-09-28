{ pkgs, ... }:
{
  imports = [
    ./quickshell.nix
  ];
  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };
  };
}
