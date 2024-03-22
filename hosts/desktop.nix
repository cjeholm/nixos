{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./common.nix
    ];

  # Host specific packages
  environment.systemPackages = with pkgs; [
  # citrix_workspace_23_09_0
  syncthing
  libreoffice
  chirp
  sdrangel
  wine64 # For Adobe DNG
  wineWowPackages.stable # For Adobe DNG. 
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "conny";
    dataDir = "/home/conny";    # Default folder for new synced folders
    configDir = "/home/conny/.config/syncthing";   # Folder for Syncthing's settings and keys
  };
}
