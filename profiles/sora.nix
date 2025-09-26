{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  # programs = {
  #   home-manager.enable = true;
  #   quickshell = {
  #     enable = true;
  #     #activeConfig = "../modules/desktop/quickshell/"
  # };
  imports = [
    ../modules/desktop/hyprland.nix
  ];
  home = {
    stateVersion = "25.11";
    username = "sora";
    homeDirectory = "/home/sora";
    packages = with pkgs; [nh jq yay];
  };
}
