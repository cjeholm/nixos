{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./../configuration.nix
    ];


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
  # zsh
  # zsh-powerlevel10k
  # zsh-autocomplete
  fish
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

  # fish stuff
  programs.fish.enable = true;
  # zsh stuff
  # programs.zsh = {
  #   enable = true;
  #   autosuggestions.enable = true;
  #   zsh-autoenv.enable = true;
  #   enableCompletion = true;
  #   syntaxHighlighting.enable = true;
  # };

}
