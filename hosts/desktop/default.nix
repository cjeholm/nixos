{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  imports = [
    # Import common settings
    ./configuration.nix
    ../../common/tuigreet.nix
    # ../../common/syncthing.nix
    ../../common/smartmon.nix
    ../../common/nvidia.nix
    ../../common/common.nix
    ../../common/printer.nix
    ../../common/bluetooth.nix
    ../../common/borgbackup.nix
    ../../common/displaycal.nix
    ../../common/polychromatic.nix
    ../../common/hyperx.nix
    ../../common/virtualbox.nix
    ../../common/diskspace.nix
    ../../common/yazi.nix
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
    mdadm
    # citrix_workspace_23_09_0
    pkgs-stable.citrix_workspace_23_09_0
    pkgs-stable.python312Packages.pyqt6 # for rebuild to pass
    libreoffice
    chirp
    pkgs-stable.sdrangel
    wine64 # For Adobe DNG
    wineWowPackages.stable # For Adobe DNG.
    steam
    gimp
    rawtherapee
    obs-studio
    cameractrls-gtk4
    krita
    kdenlive
    audacity
    ffmpeg
    # (blender.override { cudaSupport = true; })
    spotify
    inkscape
    filelight
    vlc
    v4l-utils
    ardour
    pkgs-stable.helm
    sfizz
    qpwgraph
  ];

  # Fonts
  fonts.packages = with pkgs; [
    google-fonts
  ];

  # Configure mdadm RAID management
  boot.swraid.mdadmConf = ''
    MAILADDR conny@HolmDesktop
    PROGRAM ${pkgs.mailutils}/bin/mail
  '';

  # Enable Wacom tablet
  services.xserver.wacom.enable = true;

  # Steam
  programs.steam.enable = true;

  # Ollama LLM
  services.ollama = {
    enable = false;
    acceleration = "cuda";
  };

  # Cron - needed for Backintime
  # services.cron.enable = true;

  # Enable Linux MD RAID arrays.
  # When this is enabled, mdadm will be added to the system path, and MD RAID arrays will be detected and activated automatically, both in stage-1 (initramfs) and in stage-2 (the final NixOS system).
  #This should be enabled if you want to be able to access and/or boot from MD RAID arrays. nixos-generate-config should detect it correctly in the standard installation procedure
  boot.swraid.enable = true;
}
