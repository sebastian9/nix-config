{...}: {
  programs.nixvim.plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        lua = ["selene"];
        json = ["jsonlint"];
        bash = ["shellcheck"];
      };
    };
  };
}
