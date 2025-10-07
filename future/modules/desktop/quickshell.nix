{ pkgs, ... }:
{
  home.file = {
    ".config/quickshell" = {
      source = ./quickshell;
      recursive = true;      
    };
  };
}
