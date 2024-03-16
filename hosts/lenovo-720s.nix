{ config, pkgs, ... }:

{

  imports =
    [ # Import common settings
      ./common.nix
    ];

  # HDPI for laptop monitor
  services.xserver.dpi = 180;

}
