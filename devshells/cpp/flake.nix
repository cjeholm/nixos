# Nix flake based developer shell
# Run with: nix develop
{
  description = "Dev shell for C++ with Catch2 and CMake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default =
      pkgs.mkShell
      {
        buildInputs = with pkgs; [
          catch2_3  # Testing framework
          cmake     # Build system generator
          cppcheck  # Static analysis check for memory leaks etc
          doxygen   # Source code documentation generator
        ];

        shellHook = ''
          echo "Dev shell for C++ with Catch2v3 and CMake"
        '';
      };
  };
}
