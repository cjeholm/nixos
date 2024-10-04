  { pkgs }:

pkgs.writeShellScriptBin "borg-fail-mail" ''
  /run/current-system/sw/bin/echo \"The BorgBackup service failed. Check the logs for details.\" | /run/current-system/sw/bin/mail -s \"BorgBackup_failed\" conny@localhost
''

  #/run/current-system/sw/bin/runuser -l conny -c ${pkgs.libnotify}/bin/notify-send "BorgBackup" "Service failed. Check the logs" -u critical

