{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wacomtablet
  ];

  # Enable Wacom tablet
  services.xserver.wacom.enable = true;

  # Enable the script to run at startup.

  systemd.services.wacom-touch-off = {
    description = "Disable Wacom Touch";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.wacomtablet}/bin/xsetwacom --set 27 Touch off";
      Type = "simple"; # Using "Simple" so systemd won't wait for script to finish before proceeding
    };
  };
}
