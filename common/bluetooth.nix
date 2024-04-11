{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

  bluetuith   # Bluetooth TUI

  ];


  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boo
}
