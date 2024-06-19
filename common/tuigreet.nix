{ config, pkgs, lib, ... }:

let
qtile-start = pkgs.writeShellScriptBin "qtile-start" ''
  ${pkgs.qtile}/bin/qtile start
'';
in 

{
  environment.systemPackages = with pkgs; [
    greetd.greetd
    greetd.tuigreet
    qtile-start
  ];

  services.xserver.displayManager.startx.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${qtile-start}/bin/qtile-start";
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.qtile}/bin/qtile start";
        user = "greeter";
      };
    };
  };

}
