{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ardour
    helm
    surge-XT
    dragonfly-reverb
    sfizz
    # calf
  ];

  # Trying to get calf plugins to work. Ardour marks them as "stale". IDK.
  # these env vars seems to be ignored by Ardour

  # environment.variables = {
  #   DSSI_PATH = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
  #   LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
  #   LV2_PATH = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
  #   LXVST_PATH = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
  #   VST_PATH = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
  # };
}
