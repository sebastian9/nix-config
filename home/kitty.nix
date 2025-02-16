{lib, ...}: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font.size = lib.mkDefault 16;
    font.name = "DejaVu Sans";
    settings = {
      macos_option_as_alt = "both";
    };
  };
}
