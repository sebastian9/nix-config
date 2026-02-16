{
  pkgs,
  lib,
  ...
}: {
  home = {
    file.".config/feel/feel-repl.sc" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/camunda/feel-scala/refs/tags/1.20.0/feel-repl.sc";
        sha256 = "sha256-rQL8JfNBCaNYOhqFGfGYKcwMsnspPY9MfM/tcJagkWk=";
      };
    };
  };
  programs = {
    git = {
      userName = "slopezsanchez";
      userEmail = "slopezsanchez@tesla.com";
    };
    zsh = {
      sessionVariables = {
        GITHUB_USER = "slopezsanchez";
      };
      initContent = ''
        # programs.zoxide init option wasn't working
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)";
        source ~/teleport-ssh-config/teleport-functions;
      '';
    };
  };
}
