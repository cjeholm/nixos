{ config, pkgs, lib, ... }:

{
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "conny" ];
   virtualisation.virtualbox.guest.enable = true;
   virtualisation.virtualbox.guest.draganddrop = true;
}
