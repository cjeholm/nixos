{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
    nvidia-docker
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
