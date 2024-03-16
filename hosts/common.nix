{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./../configuration.nix
    ];


  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XCURSOR_SIZE = "64";
  };

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
  xclip
  git
  eza
  zsh
  stow
  gcc
  rofi
  neofetch
  htop
  qt5ct
  i3lock
  citrix_workspace_23_09_0
  zsh-powerlevel10k
  tldr
  ];

  # Fonts
  fonts.packages = with pkgs; [
  iosevka
  ];

  # Set default shell
  users.defaultUserShell = pkgs.zsh;
  
  # zsh stuff
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

}