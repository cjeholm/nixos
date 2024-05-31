{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    displaycal

  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="0765", ATTR{idProduct}=="5020", TAG+="uaccess"
  '';
}
