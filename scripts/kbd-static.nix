{pkgs}:
pkgs.writeShellScriptBin "kbd-static" ''
  polychromatic-cli -d keyboard -o static -c \#00ffff
''
