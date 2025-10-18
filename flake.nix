{
  description = "Conny Holms NixOs Config";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs-pinned.url = "github:nixos/nixpkgs/9cba8883bbb694f4cc3c517abfb5c0b11558943b";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # zen-browser.inputs.nixpkgs.follows = "nixpkgs"; # For zen to use the same dependency versions as nixpkgs. Leaner, but can break zen if it's updated separately.

    # affinity-nix.url = "github:mrshmllow/affinity-nix";
  };

  # Tool for finding specific commits on https://www.nixhub.io/

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    # affinity-nix,
    # nixpkgs-pinned,
    ...
  }: let
    system = "x86_64-linux";

    commonArgs = {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-stable = import nixpkgs-stable commonArgs;
    # pkgs-pinned = import nixpkgs-pinned commonArgs;
  in {
    nixosConfigurations = {
      # Configurrations by hostname or '--flake .#name'

      HolmDesktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop
        ];
        specialArgs = {
          inherit pkgs-stable;
          # inherit pkgs-pinned;
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

    };
  };
}
