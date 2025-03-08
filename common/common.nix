{
  config,
  pkgs,
  pkgs-stable,
  ...
}: let
  scrot-screen = import ../scripts/scrot-screen.nix {inherit pkgs;};
  scrot-window = import ../scripts/scrot-window.nix {inherit pkgs;};
in {
  imports = [
    ./neovim.nix # Neovim and my LSP and linting stuff.
  ];

  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # XDG_CURRENT_DESKTOP = "KDE"; # enabling this breaks xdg-open
  };

  # Enable non-free nixpkgs. This is for steam-run.
  nixpkgs.config.allowUnfree = true;

  # Enable qtile
  services.xserver.windowManager.qtile.enable = true;

  # Enable local mail server
  # Be adviced! This craeates /var/spool/mail/username as a file and not as a directory. A bug?
  # Delete the file, make a dir, chown it. This drove me crazy.
  services.postfix.enable = true;

  # SSD trimming
  services.fstrim.enable = true;

  # Cursor settings - doesnt work
  # Xcursor.theme: Adwaita
  # Xcursor.size: 36
  # xserver.cursor.size = 40;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    mailutils
    scrot-screen
    scrot-window
    alacritty
    kitty
    dunst
    libnotify
    wget
    xsel
    git
    eza
    duf
    fish
    starship
    stow
    gcc
    rofi
    fastfetch
    btop
    libsForQt5.qt5ct
    i3lock
    tldr
    bat
    mqttui
    filezilla
    file
    gnumake
    scrot # Screenshot util
    nix-your-shell
    pamixer # Volume control for Pulse Audio
    fzf
    jmtpfs # for phone Media Transfer Protocol
    # pkgs-stable.xz
  ];

  # Fonts
  # Find font names with > fc-match BlexMono -s | grep Blex
  fonts = {
    packages = [pkgs.nerd-fonts.blex-mono];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["BlexMono Nerd Font"];
        sansSerif = ["BlexMono Nerd Font"];
        monospace = ["BlexMono Nerd Font"];
      };
    };
  };

  # Set default shell
  # users.defaultUserShell = pkgs.zsh;
  users.defaultUserShell = pkgs.fish;

  # Set default shell
  programs.fish = {
    enable = true;

    # This command let's me execute arbitrary binaries downloaded through channels such as mason.
    # interactiveShellInit = ''
    #  export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
    #'';
  };
}
