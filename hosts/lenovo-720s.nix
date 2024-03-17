{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./common.nix
    ];

  # Environment variables
  environment.variables = {
    XCURSOR_SIZE = "64";
  };

  # HDPI for laptop monitor
  services.xserver.dpi = 180;

  # Host specific packages
  environment.systemPackages = with pkgs; [
  citrix_workspace_23_09_0
  syncthing
  ];

  # Syncthing
  services.syncthing.enable = true;

}
