{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lollypops.url = "github:pinpox/lollypops";
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

  in {

    nixosConfigurations = {

      dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/dell
          # Overlays-module makes "pkgs.unstable" available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          lollypops.nixosModules.lollypops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.seb = import ./hosts/dell/home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      nuc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nuc
          lollypops.nixosModules.lollypops
          # Overlays-module makes "pkgs.unstable" available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nuc = import ./hosts/nuc/home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

    };

    apps."x86_64-linux".default = lollypops.apps."x86_64-linux".default { configFlake = self; };

  };
}
