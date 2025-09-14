{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # wacomtablet
  ];

  # Enable Wacom tablet
  services.xserver.wacom.enable = true;
}
