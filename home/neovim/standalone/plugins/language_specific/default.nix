_: {
  imports = [
    ./python.nix
    ./nix.nix
    ./javascript.nix
    ./dotnet.nix
    ./golang.nix
    ./lisp.nix
  ];
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        efm.enable = true; # https://github.com/mattn/efm-langserver
      };
    };
  };
}
