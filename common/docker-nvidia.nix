{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
    nvidia-docker
    # libedgetpu
  ];

  # Docker with NVIDIA GPU
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings.features.cdi = true; # For NVIDIA to work with the hardware.nvidia-container-toolkit
    };
  };

  # Coral TPU
  hardware.coral.usb.enable = true;
  # hardware.coral.pcie.enable = false;

  # udev rule for Coral TPU
  # get idVendor and idProduct with 'sudo dmesg'
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1a6e", ATTRS{idProduct}=="089a", GROUP="plugdev, MODE="0666""
  '';
}

    # DOCKER COMPOSE SETUP
    #
    # environment:
    #   NVIDIA_VISIBLE_DEVICES: all
    #   NVIDIA_DRIVER_CAPABILITIES: all
    # deploy:
    #   resources:
    #     reservations:
    #       devices:
    #         - driver: cdi
    #           device_ids:
    #             - nvidia.com/gpu=all
    #           capabilities: [gpu]
