{pkgs}:
pkgs.writeShellScriptBin "scrot-window" ''
  scrot --focused ~/Pictures/screenshots/%Y-%m-%d_%H%M%S.png
  notify-send "Window screenshot" "Saved in Pictures/screenshots"
''
