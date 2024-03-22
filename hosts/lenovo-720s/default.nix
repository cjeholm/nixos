{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./configuration.nix
      ../../common/syncthing.nix
      ../../common/common.nix
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
  libreoffice
  chirp
  sdrangel
  wine64 # For Adobe DNG
  wineWowPackages.stable # For Adobe DNG. 
  ];

}
