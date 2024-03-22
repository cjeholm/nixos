{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./configuration.nix
      ../../common/syncthing.nix
      ../../common/nvidia.nix
      ../../common/common.nix
    ];

  # Monitor order. The names of the outputs can change when Nvidia driver is installed.
  services.xserver.xrandrHeads = [
    {
      output = "HDMI-0";
      monitorConfig = ''
        Option "PreferredMode" "1920x1200"
      '';
    }
    {
      output = "DP-3";
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
  backintime
  ];

  # Steam
  programs.steam.enable = true;

}
