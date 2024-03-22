{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./configuration.nix
      ../../common/nvidia.nix
      ../../common/common.nix
    ];

  # Monitor order
  services.xserver.xrandrHeads = [
    {
      output = "HDMI-2";
      monitorConfig = ''
        Option "PreferredMode" "1920x1200"
      '';
    }
    {
      output = "DP-1";
      monitorConfig = ''
        Option "PreferredMode" "1920x1080"
      '';
    }
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
  mdadm
  steam
  ];

  # Steam
  programs.steam.enable = true;

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "conny";
    dataDir = "/home/conny";    # Default folder for new synced folders
    configDir = "/home/conny/.config/syncthing";   # Folder for Syncthing's settings and keys
  };
}
