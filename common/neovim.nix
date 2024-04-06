{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    python311Packages.python-lsp-server
  ];
}
