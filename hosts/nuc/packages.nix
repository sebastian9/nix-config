{ config, pkgs, ... }:
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch # fancy system info

    p7zip # archives

    # misc
    which
    nmap
    tree
    gnused
    gnutar
    gawk
    gnupg # GNU Privacy Guard

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    python3
    mariadb
    nextcloud29
  ];
}
