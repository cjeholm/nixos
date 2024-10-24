{
  config,
  pkgs,
  ...
}:
# smartmontools for monitoring disk status
{
  environment.systemPackages = with pkgs; [
    smartmontools
  ];

  services.smartd.enable = true;
  services.smartd.notifications.mail.recipient = "conny";
  services.smartd.notifications.mail.enable = true;
  services.smartd.notifications.x11.enable = true;
  #  services.smartd.notifications.test = true;
}
