# Nix flake based developer shell
# Run with: nix develop
# From Vimjoyer's video "The Best Way To Use Python On NixOS"
# https://www.youtube.com/watch?v=6fftiTJ2vuQ
{
  description = "Flake based dev shell for Rust";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default =
      pkgs.mkShell
      {
          buildInputs = with pkgs; [
            rustc
            cargo
            gcc
            rustfmt
            rustup
            lldb
          ];

          RUST_BACKTRACE = 1;
          RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

        env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.libz
        ];

        shellHook = ''
          echo "yer in a dev shell"
        '';
      };
  };
}
