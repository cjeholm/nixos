{ pkgs }:

pkgs.writeShellScriptBin "hyperx-rgb" ''
  openrgb --device "HyperX Quadcast S" --color 00FFFF
''
