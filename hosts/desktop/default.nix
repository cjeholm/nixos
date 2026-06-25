{
  config, # config is here for the nvidia module
  pkgs,
  pkgs-stable,
  pkgs-wine,
  # pkgs-pinned,
  inputs,
  lib,
  ...
}: let

  # --- Qtile session-desktop workaround (added 2026-08-25) -----------------
  # Upstream qtile 0.37.0 renamed its X11 session file from qtile.desktop to
  # qtile-generic.desktop, but nixpkgs' packaging (and the providedSessions
  # metadata NixOS checks against) still expects the old qtile.desktop name.
  # This breaks the `desktops` build step with:
  #   "Couldn't find provided session name, qtile.desktop, in session
  #    package python3.14-qtile-0.37.0"
  #
  # Fix: build a tiny package that just supplies a correctly-named
  # qtile.desktop pointing at the real qtile binary, and force it to
  # *replace* (not append to) services.displayManager.sessionPackages,
  # since the module's own broken package must be fully excluded — leaving
  # it in the list still fails validation even alongside a working one.
  #
  # Remove this whole block once nixpkgs fixes the desktop-file naming
  # upstream (check https://github.com/NixOS/nixpkgs for a qtile packaging
  # fix mentioning qtile-generic.desktop), then revert sessionPackages back
  # to the module default (i.e. delete this override entirely).
  #
  # By removing this line below:
  # services.displayManager.sessionPackages = lib.mkForce [ qtileDesktopFix ];
  # ---------------------------------------------------------------------

 qtileDesktopFix = pkgs.writeTextFile {
  name = "qtile-desktop-fix";
  destination = "/share/xsessions/qtile.desktop";
  text = ''
    [Desktop Entry]
    Name=Qtile
    Comment=Qtile Session
    Exec=${pkgs.python3.pkgs.qtile}/bin/qtile start
    Type=Application
    Keywords=wm;tiling
  '';
  passthru.providedSessions = [ "qtile" ];
};

in {
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
    # ../../common/docker.nix
  ];

  # qtile fix
  services.displayManager.sessionPackages = lib.mkForce [ qtileDesktopFix ];

  # Set hdd spindown timer. The value of 0 disables spindown, the values from 1 to 240 specify multiples of 5 seconds and values from 241 to 251 specify multiples of 30 minutes.
  systemd.services.hdparm-spindown = {
    description = "Set HDD spindown timers";
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "hdparm-spindown" ''
        ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sda
        ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdc
        ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdd
        ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sde
        ${pkgs.hdparm}/sbin/hdparm -S 24 /dev/sdf
      '';
    };
  };

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
    darktable
    godot
    gdscript-formatter

    # opentrack
    # aitrack

    # From stable
    pkgs-stable.rawtherapee
    pkgs-stable.audacity
    pkgs-stable.citrix_workspace_23_11_0

    # Wine flake. Wine 9 for Adobe DNG.
    pkgs-wine.wine64 # For Adobe DNG
    pkgs-wine.wineWow64Packages.stable # For Adobe DNG.

    # Zen Browser flake
    inputs.zen-browser.packages."${pkgs.system}".default

    # Blender with override for cuda. CUDA cache for binary.
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
