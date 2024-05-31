{ config, pkgs, pkgs-stable, ... }:

{

  imports =
    [
      ./neovim.nix  # Neovim and my LSP and linting stuff.
    ];


  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  # Enable non-free nixpkgs. This is for steam-run.
  nixpkgs.config.allowUnfree = true;

  # Enable qtile
  services.xserver.windowManager.qtile.enable = true;

  # Cursor settings - doesnt work
  # Xcursor.theme: Adwaita
  # Xcursor.size: 36
  # xserver.cursor.size = 40;

# List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    qtile
    wget
    neovim
    xsel
    git
    eza
    fish
    starship
    stow
    gcc
    rofi
    neofetch
    btop
    qt5ct
    i3lock
    tldr
    bat
    mqttui
    filezilla
    displaycal

    # pkgs-stable.xz
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
  ];

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
