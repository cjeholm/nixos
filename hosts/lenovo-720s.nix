{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./common.nix
    ];

  # Kernel stuff for Intel Gpu 
  services.xserver.videoDrivers = [ "intel" ];  # modesetting didn't help
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];  # bbswitch
  boot.kernelParams = [ "acpi_rev_override=5" "i915.enable_guc=2" ];  
  boot.kernelModules = [ "kvm-intel" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

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
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "conny";
    dataDir = "/home/conny";    # Default folder for new synced folders
    configDir = "/home/conny/.config/syncthing";   # Folder for Syncthing's settings and keys
  };
}
