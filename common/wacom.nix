{ config, pkgs, pkgs-stable, ... }:

{
  # Enable Wacom tablet
  xserver.wacom.enable = true;
}
