{ config, pkgs, lib, ... }:

let
hyperx-rgb = pkgs.writeShellScriptBin "hyperx-rgb" ''
  ${pkgs.openrgb}/bin/openrgb --device "HyperX Quadcast S" --color 00FFFF
'';
in 

{

  environment.systemPackages = with pkgs; [
    hyperx-rgb
  ];


# Enable OpenRGB
  services.hardware.openrgb.enable = true;

# Enable the script to run at startup.

#  systemd.services.hyperx-rgb = {
#    description = "HyperX Quadcast S RGB";
#    wantedBy = [ "multi-user.target" ];
#    serviceConfig = {
#      ExecStart = "${pkgs.bash}/bin/bash ${hyperx-rgb}/bin/hyperx-rgb";
#      # ExecStart = "${pkgs.bash}/bin/bash hyperx-rgb";
#      # Restart = "on-failure";
#      Type = "oneshot";
#    };
#  };
}
