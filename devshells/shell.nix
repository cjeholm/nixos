# Nix channel based developer shell
# Run with: nix-shell
let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    packages = [
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.requests
      ]))
    ];
  }
