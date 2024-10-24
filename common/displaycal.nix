{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    displaycal
  ];

  # udev rule for usb instrument permission
  # get idVendor and idProduct with 'sudo dmesg'

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="0765", ATTR{idProduct}=="5020", TAG+="uaccess"
  '';
}
