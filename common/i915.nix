{
  config,
  lib,
  pkgs,
  ...
}: {
  # Test this one... nope.
  # boot.kernelParams = ["intel_iommu=igfx_off"];
  # boot.kernelParams = ["i915.force_probe=5917"];
  # Possible fix for screen flickering with modesetting. Didn't work but keeping it here.
  # boot.kernelParams = [ "i915.enable_psr=0" "intel_idle.max_cstate=2" ];

  # Possible fix for screen flickering with modesetting. Didn't work but keeping it here.
  # boot.kernelParams = [ "intel_idle.max_cstate=4" ];
  options.hardware.intelgpu.loadInInitrd =
    lib.mkEnableOption (
      lib.mdDoc
      "loading `i195` kernelModule at stage 1. (Add `i915` to `boot.initrd.kernelModules`)"
    )
    // {
      default = true;
    };

  config = lib.mkMerge [
    (lib.mkIf config.hardware.intelgpu.loadInInitrd {
      boot.initrd.kernelModules = ["i915"];
    })
    {
      environment.variables = {
        VDPAU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
      };

      hardware.graphics.extraPackages = with pkgs; [
        (
          if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11")
          then vaapiIntel
          else intel-vaapi-driver
        )
        libvdpau-va-gl
        intel-media-driver
      ];
    }
  ];
}
