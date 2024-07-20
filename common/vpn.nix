{ config, pkgs, ... }:

{
  services.openvpn.servers = {
    HolmHomeVPN  = { config = '' config /home/conny/Documents/VPN/HolmHomeVPN.ovpn ''; };
  };
}

# systemctl start openvpn-HolmHomeVPN.service
