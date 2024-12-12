{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # pkgs-stable.sdrangel
    pkgs-stable.sdrangel
  ];

  # Blacklist the DVB driver
  boot.blacklistedKernelModules = ["dvb_usb_rtl28xxu"];

  # services.udev.packages = [pkgs.rtl-sdr];

  # udev rule for usb instrument permission
  # get idVendor and idProduct with 'sudo dmesg'
  # RTL2832U OEM vid/pid, e.g. ezcap EzTV668 (E4000), Newsky TV28T (E4000/R820T) etc.
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", MODE:="0666"
  '';
}
