{pkgs, ...}: {
  environment.systemPackages = [pkgs.nginx];
}
