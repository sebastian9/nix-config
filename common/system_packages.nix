{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    kitty
    git
    fzf
    lf
    nnn # terminal file manager

    # utilities
    wget
    curl
    xclip
    busybox
    gcc
  ];

  nixpkgs.config.allowUnfree = true;
}
