{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixos-24.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
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
    self, nixpkgs, nixpkgs-darwin, nix-darwin, nixpkgs-unstable, home-manager, lollypops, ...
  }:

  let

    hostnames = {
      dell = "dell";
      nuc = "nuc";
      zima = "zima";
      work_mac = "LUSHQF0X7F3GW";
    };

    usernames = {
      dell = "seb";
      nuc = "nuc";
      zima = "zima";
      work_mac = "slopezsanchez";
    };

    systems = {
      dell = "x86_64-linux";
      nuc = "x86_64-linux";
      zima = "aarch64-linux";
      work_mac = "aarch64-darwin";
    }

    overlay-unstable = system: final: prev: {
      unstable = import nixpkgs-unstable {
        system = ${system};
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
      system = systems.${name};
      specialArgs = {
        user = usernames.${name};
        host = hostnames.${name};
      };
      modules = [
        ./hosts/${name}
        { nixpkgs.overlays = [ (overlay-unstable systems.${name}) ]; }
        lollypops.nixosModules.lollypops
        home-manager.nixosModules.home-manager
        (home-manager-defaults usernames.${name} hostnames.${name})
      ];
    };

    mkConfigDarwin = name: nixpkgs.lib.nixosSystem {
      system = systems.${name};
      specialArgs = {
        user = usernames.${name};
        host = hostnames.${name};
      };
      modules = [
        ./hosts/${name}
        lollypops.nixosModules.lollypops
        home-manager.nixosModules.home-manager
        # (home-manager-defaults usernames.${name} hostnames.${name})
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
