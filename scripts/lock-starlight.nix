{ pkgs }:

pkgs.writeShellScriptBin "lock-starlight" ''
  polychromatic-cli -d keyboard -o starlight -p single:3 -c \#00ffff
  polychromatic-cli -d mouse -z scroll -o reactive -c \#ff0000 -p 1
  polychromatic-cli -d mouse -z logo -o reactive -c \#ff0000 -p 1

  i3lock $* -n; kbd-mouse-static 
''
