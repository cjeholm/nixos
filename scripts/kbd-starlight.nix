{ pkgs }:

pkgs.writeShellScriptBin "kbd-starlight" ''
  polychromatic-cli -d keyboard -o starlight -p single:3 -c \#00ffff
''
