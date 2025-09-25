{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  #imports = [
  #  ../modules/desktop/hyprland.nix
  #];
  home = {
    stateVersion = "25.11";
    username = "sora";
    homeDirectory = "/home/sora";
    packages = with pkgs; [nh jq yay];
  };
}
