{ config, pkgs, ... }:

{

  # Add Syncthing package
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  # Enable and set up Syncthing
  services.syncthing = {
    enable = true;
    user = "conny";
    dataDir = "/home/conny";    # Default folder for new synced folders
    configDir = "/home/conny/.config/syncthing";   # Folder for Syncthing's settings and keys
  };

}
