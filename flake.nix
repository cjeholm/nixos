{
  description = "Conny Holms NixOS Config";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs-wine.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-wine.url = "github:nixos/nixpkgs/b134951a4c9f3c995fd7be05f3243f8ecd65d798";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  # Tool for finding specific commits on https://www.nixhub.io/

  outputs = { nixpkgs, nixpkgs-stable, nixpkgs-wine, ... } @ inputs: let
    # Helper function to create pkgs with common config
    mkPkgs = system: input: import input {
      inherit system;
      config.allowUnfree = true;
    };
    
    # Helper to create system configurations
    mkSystem = system: modules: nixpkgs.lib.nixosSystem {
      inherit system modules;
      specialArgs = {
        pkgs-stable = mkPkgs system nixpkgs-stable;
        pkgs-wine = mkPkgs system nixpkgs-wine;
        inherit inputs;
      };
    };
  in {
    nixosConfigurations = {
      HolmDesktop = mkSystem "x86_64-linux" [ ./hosts/desktop ];
      HolmLaptop = mkSystem "x86_64-linux" [ ./hosts/lenovo-720s ];
      # HolmPi = mkSystem "aarch64-linux" [ ./hosts/raspberry-pi ];
    };
  };
}
