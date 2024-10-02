{ config, pkgs, ... }:

let
  borg-fail-mail = import ../scripts/borg-fail-mail.nix { inherit pkgs; };
in 
{

  environment.systemPackages = with pkgs; [
  borg-fail-mail
  borgbackup
  ];


  # Configure Borg backup
  services.borgbackup.jobs.homedir = {
    paths = "/home/conny";
    encryption.mode = "none";
    repo = "/mnt/Backup-HDD/home-conny";
    compression = "auto,zstd";
    startAt = "daily";

    exclude = [
      "/home/conny/Downloads"
      "/home/conny/Games"
      "/home/conny/.cache"
      "/home/conny/.local/share/Steam"
    ];

    # Notifications
    preHook = ''${pkgs.libnotify}/bin/notify-send "BorgBackup" "Backup is starting..."'';
    postHook = ''${pkgs.libnotify}/bin/notify-send "BorgBackup" "Backup has completed!"'';

    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = -1;  # Keep at least one archive for each month
    };

    };

    # Send mail on failure
  systemd.services."borgbackup-job-homedir".onFailure = [ "mail-on-borg-failure.service" ];

  # Here follows a service config for mail notifications on fail
  systemd.services.mail-on-borg-failure = {
    description = "Send Email on Borg Failure";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/borg-fail-mail";
    };

    # This service will be triggered only on failure of other services.
    wantedBy = [ ];
  };

}
