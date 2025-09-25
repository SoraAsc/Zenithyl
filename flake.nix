{
  description = "Home-manager + Hyprland";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # Unstable Nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # Home-manager configurations
      homeConfigurations =
        {
          sora = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./profiles/sora.nix ];
          };
        };
    };
}
