{ pkgs }:

pkgs.writeShellScriptBin "scrot-screen" ''
  scrot ~/Pictures/screenshots/%Y-%m-%d_%H%M%S.png
  notify-send "Fullscreen screenshot" "Saved in Pictures/screenshots"
''
