{ ... }:
{
  imports = [ ./docker-compose.nix ];
  networking.firewall.allowedTCPPorts = [ 3000 ];
}
