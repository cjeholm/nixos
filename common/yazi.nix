{
  pkgs,
  ...
}:
# Yazi file manager and a bunch of stuff for additional features
{
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    p7zip
    jq
    viu
    poppler
    fd
    ripgrep
    fzf
    zoxide
    imagemagick
    xsel
    ueberzugpp

    mediainfo
    exiftool
    mpv
    feh
  ];

  # Yazi terminal file manager
  programs.yazi.enable = true;

  programs.yazi.settings.theme = {
    status = {
      separator_open = "";
      separator_close = "";
    };
  };
}
