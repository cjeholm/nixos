{ config, pkgs, ... }:

# Yazi file manager and a bunch of stuff for additional features

{

  environment.systemPackages = with pkgs; [

    ffmpegthumbnailer
    p7zip
    jq
    viu
    poppler
    fd
    rg
    fzf
    zoxide
    imagemagick
    xsel

    mediainfo
    exiftool
    mpv
  ];

  # Yazi terminal file manager
  programs.yazi.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
  ];

}
