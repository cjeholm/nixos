{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Import common settings
    ./configuration.nix
    ../../common/common.nix
  ];
}
