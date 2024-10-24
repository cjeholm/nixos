{
  config,
  pkgs,
  pkgs-stable,
  ...
}: let
  kbd-starlight = import ../scripts/kbd-starlight.nix {inherit pkgs;};
  kbd-static = import ../scripts/kbd-static.nix {inherit pkgs;};
  kbd-mouse-static = import ../scripts/kbd-mouse-static.nix {inherit pkgs;};
  lock-starlight = import ../scripts/lock-starlight.nix {inherit pkgs;};
in {
  environment.systemPackages = with pkgs; [
    openrazer-daemon # Control mouse and keyboard RGB
    pkgs-stable.polychromatic

    kbd-starlight
    kbd-static
    kbd-mouse-static

    lock-starlight
  ];

  # Openrazer for RGB
  hardware.openrazer = {
    enable = true;
    users = ["conny"];
  };
}
