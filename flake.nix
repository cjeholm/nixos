{
  description = "Conny Holms NixOs Config";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-pinned.url = "github:nixos/nixpkgs/9cba8883bbb694f4cc3c517abfb5c0b11558943b";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-pinned,
    ...
  }: let
    system = "x86_64-linux";

    commonArgs = {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-stable = import nixpkgs-stable commonArgs;
    pkgs-pinned = import nixpkgs-pinned commonArgs;
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
          inherit inputs;
        };
      };

      HolmDesktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop
        ];
        specialArgs = {
          inherit pkgs-stable;
          inherit pkgs-pinned;
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
