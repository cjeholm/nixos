{pkgs, ...}: {
  environment.systemPackages = [
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
    };
  };
  users.users.conny.extraGroups = ["docker"];
}
