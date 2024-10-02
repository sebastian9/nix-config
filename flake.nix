{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lollypops.url = "github:pinpox/lollypops";
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
          # Overlays-module makes "pkgs.unstable" available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
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
          # Overlays-module makes "pkgs.unstable" available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          home-manager.nixosModules.home-manager
          (home-manager-defaults "nuc" "nuc")
        ];
      };

      zima = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/zima
          lollypops.nixosModules.lollypops
          # Overlays-module makes "pkgs.unstable" available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          home-manager.nixosModules.home-manager
          (home-manager-defaults "zima" "zima")
        ];
      };

    };

    apps.${system}.default = lollypops.apps.${system}.default { configFlake = self; };

  };
}
