{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#    home-manager.url = "github:nix-community/home-manager/release-23.11";
#    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

#  outputs = { nixpkgs, home-manager, ... }: 
  outputs = { nixpkgs, ... }: 

    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    nixosConfigurations = {
# TODO please change the hostname to your own

      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };

      hunj = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hunj.nix
        ];
      };


    };

  };
}
