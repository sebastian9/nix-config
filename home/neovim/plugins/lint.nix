{...}: {
  programs.nixvim.plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        go = ["golangci-lint"];
        # nix = [ "statix" ]; # TODO: why this fails on nix
        lua = ["selene"];
        python = ["ruff" "mypy"];
        javascript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        typescript = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        json = ["jsonlint"];
        bash = ["shellcheck"];
      };
    };
  };
}
