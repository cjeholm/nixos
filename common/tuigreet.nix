{ config, pkgs, lib, ... }:

let
start-qtile = pkgs.writeShellScriptBin "start-qtile" ''
  ${pkgs.qtile}/bin/qtile start
'';
in 

{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${start-qtile}/bin/start-qtile";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
  greetd.greetd
  greetd.tuigreet
  start-qtile
  ];

services.displayManager.sddm.enable = false;

}
