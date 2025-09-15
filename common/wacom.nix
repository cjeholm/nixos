{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # config.boot.kernelPackages.digimend
    # wacomtablet
  ];

  # Enable Wacom tablet
  services.xserver.wacom.enable = true;

  hardware.opentabletdriver.enable = true;
  services.xserver.digimend.enable = true;
}
