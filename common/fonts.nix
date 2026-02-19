{pkgs, ...}: {
  fonts.packages = with pkgs;
    [
      meslo-lgs-nf
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
