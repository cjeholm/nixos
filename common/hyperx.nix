{ config, pkgs, ... }:

let
hyperx-rgb = import ../scripts/hyperx-rgb.nix { inherit pkgs; };
in 

{

  environment.systemPackages = with pkgs; [
    hyperx-rgb
  ];


# Enable OpenRGB
  services.hardware.openrgb.enable = true;

# Enable the script to run at startup.
# THIS IS BROKEN

  systemd.services.hyperx-rgb = {
    description = "HyperX Quadcast S RGB";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash hyperx-rgb";
      # ExecStart = "${pkgs.bash}/bin/bash hyperx-rgb";
      Restart = "on-failure";
    };
  };
}
