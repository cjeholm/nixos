{ config, pkgs, lib, ... }:

let
check-diskspace = pkgs.writeShellScriptBin "check-diskspace" ''
# Set threshold for disk space (e.g., 80% use)
NORMAL=80
CRITICAL=90

# Get the partition's used disk space (in percentage)
use_root=$(df / | grep / | /run/current-system/sw/bin/awk '{print $5}' | sed 's/%//g')
use_boot=$(df /boot | grep /boot | /run/current-system/sw/bin/awk '{print $5}' | sed 's/%//g')
use_home=$(df /home | grep /home | /run/current-system/sw/bin/awk '{print $5}' | sed 's/%//g')

# Check if used space is more than the threshold
if [ "$use_root" -gt "$NORMAL" ]; then
  level="normal"
  if [ "$use_root" -gt "$CRITICAL" ]; then
    level="critical"
  fi
  /run/current-system/sw/bin/notify-send "Low Disk Space" "Your root partition is running low on disk space: $use_root% used" -u $level
fi

if [ "$use_boot" -gt "$NORMAL" ]; then
  level="normal"
  if [ "$use_boot" -gt "$CRITICAL" ]; then
    level="critical"
  fi
  /run/current-system/sw/bin/notify-send "Low Disk Space" "Your boot partition is running low on disk space: $use_boot% used" -u $level
fi

if [ "$use_home" -gt "$NORMAL" ]; then
  level="normal"
  if [ "$use_home" -gt "$CRITICAL" ]; then
    level="critical"
  fi
  /run/current-system/sw/bin/notify-send "Low Disk Space" "Your home partition is running low on disk space: $use_home% used" -u $level
fi
'';

in 

{
  environment.systemPackages = with pkgs; [
    check-diskspace
  ];

  # Create a service to run the script
  systemd.services.diskspace= {
    description = "Check disk space and send notifications";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${check-diskspace}/bin/check-diskspace";
      Environment = "DISPLAY=:0.0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
      User = "conny";
    };
  };

  # Create a timer
  systemd.timers.diskspace = {
    description = "Run diskspace script every five minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/5:0"; # This means every 5 minutes
      Persistent = false;      # Ensures the script runs even after the system was off during a scheduled run
    };
  };
}
