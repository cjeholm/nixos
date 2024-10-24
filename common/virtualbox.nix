{
  config,
  pkgs,
  lib,
  ...
}: {
  # for host machine
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["conny"];

  # for guest machine
  #   virtualisation.virtualbox.guest.enable = true;
  #   virtualisation.virtualbox.guest.draganddrop = true;
}
