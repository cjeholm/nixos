# Nix flake based developer shell
# Run with: nix develop
{
  description = "Dev shell for Python";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.python312Packages.requests
          ];

          shellHook = ''
            echo "yer in a dev shell"
          '';
        };
  };
}
