{ config, pkgs, ... }:

{

#   imports =
#     [ # Include the results of the hardware scan.
#       ./../configuration.nix
#     ];


  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
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
  fish
  starship
  stow
  gcc
  rofi
  neofetch
  htop
  qt5ct
  i3lock
  tldr
  ];

  # Fonts
  fonts.packages = with pkgs; [
  iosevka
  ];

  # Set default shell
  # users.defaultUserShell = pkgs.zsh;
  users.defaultUserShell = pkgs.fish;

  # Set default shell
  programs.fish.enable = true;

}
