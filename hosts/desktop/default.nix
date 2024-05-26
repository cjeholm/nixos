{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./configuration.nix
    # ../../common/syncthing.nix
      ../../common/nvidia.nix
      ../../common/common.nix
      ../../common/wacom.nix
      ../../common/printer.nix
      ../../common/bluetooth.nix
    ];

  # Set hdd spindown timer. The value of 0 disables spindown, the values from 1 to 240 specify multiples of 5 seconds and values from 241 to 251 specify multiples of 30 minutes.
  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sda
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdc
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdd
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sde
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdf
  '';

  # Monitor order. The names of the outputs can change when Nvidia driver is installed.
  services.xserver.xrandrHeads = [
    {
      output = "HDMI-0";
      monitorConfig = ''
        Option "PreferredMode" "3440x1440"
      '';
    }
  ];

  # Host specific packages
  environment.systemPackages = with pkgs; [
  citrix_workspace_23_09_0
  libreoffice
  chirp
  sdrangel
  wine64 # For Adobe DNG
  wineWowPackages.stable # For Adobe DNG. 
  mdadm # RAID management
  steam
  backintime
  gimp
  rawtherapee
  obs-studio
  krita
  blockbench
  (blender.override { cudaSupport = true; })
  # spotify
  inkscape
  openrazer-daemon # Control mouse and keyboard RGB
  polychromatic
  filelight
  ];

  # Openrazer for RGB
  hardware.openrazer = {
    enable = true;
    users = [ "conny" ];
  };

  # Steam
  programs.steam.enable = true;

  # Cron - needed for Backintime
  services.cron.enable = true;

  # Enable Linux MD RAID arrays.
  # When this is enabled, mdadm will be added to the system path, and MD RAID arrays will be detected and activated automatically, both in stage-1 (initramfs) and in stage-2 (the final NixOS system).
  #This should be enabled if you want to be able to access and/or boot from MD RAID arrays. nixos-generate-config should detect it correctly in the standard installation procedure
  boot.swraid.enable = true;

}
