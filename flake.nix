{
  description = "Conny Holms NixOs Config";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    # pkgs-stable = nixpkgs-stable.legacyPackages.${system};

    commonArgs = {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs commonArgs;
    pkgs-stable = import nixpkgs-stable commonArgs;
  in {
    nixosConfigurations = {
      # Configurrations by hostname or '--flake .#name'

      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./common/common.nix
        ];
        specialArgs = {
          inherit pkgs-stable;
        };
      };

      HolmDesktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop
        ];
        specialArgs = {
          inherit pkgs-stable;
          inherit inputs;
        };
      };

      HolmLaptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/lenovo-720s
        ];
        specialArgs = {
          inherit pkgs-stable;
          inherit inputs;
        };
      };

      nixos-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-vm
        ];
        specialArgs = {
          inherit pkgs-stable;
        };
      };
    };
  };
}
