{ config, pkgs, ... }:

# let
# start-qtile = pkgs.writeShellScriptBin "start-qtile" ''
#   ${pkgs.qtile}/bin/qtile start
# '';
# in 

{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${qtile}/bin/qtile start";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
  greetd.greetd
  greetd.tuigreet
#  start-qtile
  ];

services.xserver = {
  enable = true;
  windowManager.qtile.enable = true;
  displayManager.defaultSession = "none+qtile";
};

}
