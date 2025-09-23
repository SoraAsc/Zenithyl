{pkgs, ...}: 
{
 home.username = "sora";
  home.homeDirectory = "/home/sora/";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [nh cowsay asciiquarium];
  programs.home-manager.enable = true;
  }
