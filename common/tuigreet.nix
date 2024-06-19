{ config, pkgs, ... }:

{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.qtile}/bin/qtile start";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
  greetd.greetd
  greetd.tuigreet
  ];

services.xserver.displayManager.startx.enable = true;

# services.xserver = {
#   enable = true;
#   windowManager.qtile.enable = true;
#   displayManager.defaultSession = "none+qtile";
# };

}
