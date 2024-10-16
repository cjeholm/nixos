{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./configuration.nix
      ../../common/tuigreet.nix
      ../../common/i915.nix
    # ../../common/syncthing.nix
      ../../common/smartmon.nix
      ../../common/common.nix
      ../../common/bluetooth.nix
      ../../common/vpn.nix
      ../../common/diskspace.nix
    ];

  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XCURSOR_SIZE = "32";
  };

  # HDPI for laptop monitor
  services.xserver.dpi = 180;

  # Host specific packages
  environment.systemPackages = with pkgs; [
    citrix_workspace_23_09_0
    libreoffice
    chirp
    sdrangel
    wine64 # For Adobe DNG
    wineWowPackages.stable # For Adobe DNG. 
    krita
  ];

}
