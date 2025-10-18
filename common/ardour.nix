{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ardour
    helm
    # surge-XT
    dragonfly-reverb
    sfizz
    # calf
  ];
}
