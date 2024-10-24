{pkgs}:
pkgs.writeShellScriptBin "kbd-mouse-static" ''
  polychromatic-cli -d keyboard -o static -c \#00ffff
  polychromatic-cli -d mouse -z logo -o static -c \#00ffff
  polychromatic-cli -d mouse -z scroll -o static -c \#00ffff
''
