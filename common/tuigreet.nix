{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    greetd.greetd
    greetd.tuigreet
  ];

  services.xserver.displayManager.startx.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
        # I can not get the default choice to work!
        # Workaround by using the --remember-session option
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.qtile}/bin/qtile start";
        user = "greeter";
      };
    };
  };

}
