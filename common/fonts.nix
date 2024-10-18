{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];
}
