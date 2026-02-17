{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    # Import common settings
    ./configuration.nix
    ../../common/tuigreet.nix
    # ../../common/i915.nix
    # ../../common/syncthing.nix
    ../../common/pipewire.nix
    ../../common/smartmon.nix
    ../../common/common.nix
    ../../common/bluetooth.nix
    ../../common/vpn.nix
    ../../common/diskspace.nix
    ../../common/yazi.nix
    ../../common/rtl-sdr.nix
  ];

  # Environment variables
  environment.variables = {
    XCURSOR_SIZE = "32";
  };

  # HDPI for laptop monitor
  services.xserver.dpi = 180;

  # Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boo

  # Host specific packages
  environment.systemPackages = with pkgs; [
    libreoffice
    chirp

    # From stable
    pkgs-stable.citrix_workspace_23_09_0
    
    # Wine flake. Wine 9 for Adobe DNG.
    pkgs-wine.wine64 # For Adobe DNG
    pkgs-wine.wineWow64Packages.stable # For Adobe DNG.
  ];

  services.syncthing = {
    enable = false;
    group = "users";
    user = "conny";
    dataDir = "/home/conny/syncthing"; # Default folder for new synced folders
    configDir = "/home/conny/.config/syncthing"; # Folder for Syncthing's settings and keys
  };
}
