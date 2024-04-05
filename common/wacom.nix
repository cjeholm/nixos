{ config, pkgs, pkgs-stable, ... }:

{
  # Enable Wacom tablet
  services.xserver.wacom.enable = true;
}
