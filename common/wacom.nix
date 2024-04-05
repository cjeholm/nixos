{ config, pkgs, pkgs-stable, ... }:

{
  # Enable Wacom tablet
  serviecs.xserver.wacom.enable = true;
}
