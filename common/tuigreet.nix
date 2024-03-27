{ config, pkgs, ... }:

{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd qtile start";
        user = "conny";
      };
    };
  };

  environment.systemPackages = with pkgs; [
  greetd.greetd
  greetd.tuigreet
  ];

}
