{
  config, # config is here for the nvidia module
  pkgs,
  pkgs-stable,
  pkgs-wine,
  # pkgs-pinned,
  inputs,
  ...
}: {
  imports = [
    # Import common settings
    ./configuration.nix
    ../../common/tuigreet.nix
    # ../../common/syncthing.nix
    ../../common/smartmon.nix
    ../../common/pipewire.nix
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
    ../../common/ardour.nix
    ../../common/rtl-sdr.nix
    # ../../common/wacom.nix
    # ../../common/docker-nvidia.nix
    ../../common/docker.nix
  ];

  # Set hdd spindown timer. The value of 0 disables spindown, the values from 1 to 240 specify multiples of 5 seconds and values from 241 to 251 specify multiples of 30 minutes.
  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sda
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdc
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdd
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sde
    ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdf
  '';

  # Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boo

  # Monitor order. The names of the outputs can change when Nvidia driver is installed.
  services.xserver.xrandrHeads = [
    {
      output = "HDMI-0";
      monitorConfig = ''
        Option "PreferredMode" "3440x1440"
      '';
    }
  ];

  # Overlays
  #  nixpkgs.overlays = [
  # Overlay: Use `self` and `super` to express
  # the inheritance relationship
  #   (self: super: {
  #     yazi = pkgs-pinned.yazi;
  #   })
  # ];

  # Host specific packages
  environment.systemPackages = with pkgs; [
    mdadm
    nvtopPackages.nvidia
    libreoffice
    chirp
    steam
    gimp
    obs-studio
    cameractrls-gtk4
    gromit-mpx
    krita
    kdePackages.kdenlive
    ffmpeg
    spotify
    inkscape
    vlc
    v4l-utils
    qpwgraph

    # From stable
    pkgs-stable.rawtherapee
    pkgs-stable.audacity
    pkgs-stable.citrix_workspace_23_11_0

    # Wine flake. Wine 9 for Adobe DNG.
    pkgs-wine.wine64 # For Adobe DNG
    pkgs-wine.wineWow64Packages.stable # For Adobe DNG.

    # Zen Browser flake
    inputs.zen-browser.packages."${pkgs.system}".default

    # Blender with override for cuda. Compile time!
    # (blender.override {cudaSupport = true;})
  ];

  # Fonts
  # fonts.packages = with pkgs; [
    # google-fonts
  # ];

  # Configure mdadm RAID management
  boot.swraid.mdadmConf = ''
    MAILADDR conny@HolmDesktop
    PROGRAM /run/current-system/sw/bin/true
  '';
  # PROGRAM ${pkgs.mailutils}/bin/mail

  # Steam
  programs.steam.enable = true;

  # Syncthing
  services.syncthing = {
    enable = false;
    group = "users";
    user = "conny";
    dataDir = "/home/conny/syncthing"; # Default folder for new synced folders
    configDir = "/home/conny/.config/syncthing"; # Folder for Syncthing's settings and keys
  };

  # Ollama LLM
  services.ollama = {
    enable = false;
    # acceleration = "cuda";
    package = pkgs.ollama-cuda;
  };
  services.open-webui = {
    enable = false;
    port = 8445;
  };

  # Firewall
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [8971];
    # allowedUDPPortRanges = [
    #   {
    #     from = 4000;
    #     to = 4007;
    #   }
    #   {
    #     from = 8000;
    #     to = 8010;
    #   }
    # ];
  };
  # Cron - needed for Backintime
  # services.cron.enable = true;

  # Enable Linux MD RAID arrays.
  # When this is enabled, mdadm will be added to the system path, and MD RAID arrays will be detected and activated automatically, both in stage-1 (initramfs) and in stage-2 (the final NixOS system).
  #This should be enabled if you want to be able to access and/or boot from MD RAID arrays. nixos-generate-config should detect it correctly in the standard installation procedure
  boot.swraid.enable = true;
}
