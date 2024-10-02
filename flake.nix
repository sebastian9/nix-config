{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    lollypops.url = "github:pinpox/lollypops";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self, nixpkgs, nixpkgs-unstable, home-manager, lollypops, ...
  }:

  let

    system = "x86_64-linux";

    hostnames = {
      dell = "dell";
      nuc = "nuc";
      zima = "zima";
    };

    usernames = {
      dell = "seb";
      nuc = "nuc";
      zima = "zima";
    };

    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    home-manager-defaults = user: host: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ./hosts/${host}/home.nix;
      home-manager.backupFileExtension = "backup";
      home-manager.extraSpecialArgs = {
        user = user;
      };
    };

    mkConfig = name: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        user = usernames.${name};
        host = hostnames.${name};
      };
      modules = [
        ./hosts/${name}
        { nixpkgs.overlays = [ overlay-unstable ]; }
        lollypops.nixosModules.lollypops
        home-manager.nixosModules.home-manager
        (home-manager-defaults usernames.${name} hostnames.${name})
      ];
    };

  in {

    nixosConfigurations = {

      dell = mkConfig "dell";
      nuc = mkConfig "nuc";
      zima = mkConfig "zima";

    };

    apps.${system}.default = lollypops.apps.${system}.default { configFlake = self; };

  };
}
