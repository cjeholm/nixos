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

  # Coral TPU
  # The user needs to be added to the group 'coral'
  # This seems broken on NixOS. The Coral device does not get initialized and has the wrong VID/PID
  # hardware.coral.usb.enable = true;
  # # hardware.coral.pcie.enable = false;

  # udev rule for Coral TPU
  # get idVendor and idProduct with 'lsusb'
  # services.udev.extraRules = ''
  #   # Give access to the Coral USB TPU in its initial (uninitialized) state
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="1a6e", ATTRS{idProduct}=="089a", MODE="0666", GROUP="plugdev"
  #
  #   # Give access to the Coral USB TPU after initialization
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="9302", MODE="0666", GROUP="plugdev"
  # '';
}
