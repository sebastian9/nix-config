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
    };

  in {

    nixosConfigurations = {

      dell = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/dell
          { nixpkgs.overlays = [ overlay-unstable ]; }
          lollypops.nixosModules.lollypops
          home-manager.nixosModules.home-manager
          (home-manager-defaults "seb" "dell")
        ];
      };

      nuc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nuc
          lollypops.nixosModules.lollypops
          { nixpkgs.overlays = [ overlay-unstable ]; }
          home-manager.nixosModules.home-manager
          (home-manager-defaults "nuc" "nuc")
        ];
      };

      zima = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/zima
          lollypops.nixosModules.lollypops
          { nixpkgs.overlays = [ overlay-unstable ]; }
          home-manager.nixosModules.home-manager
          (home-manager-defaults "zima" "zima")
        ];
      };

    };

    apps.${system}.default = lollypops.apps.${system}.default { configFlake = self; };

  };
}
