{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    lollypops.url = "github:pinpox/lollypops";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    hostNames = {
      dell = "dell";
      nuc = "nuc";
      zima = "zima";
      workWsl = "DUS-MXL3324Q2P";
    };

    hostAliases = inputs.nixpkgs.lib.lists.unique (builtins.attrNames hostNames);

    hostNames-darwin = {
      workMac = "LUSHQF0X7F3GW";
      macAir = "Anas-MacBook-Air";
    };

    hostAliases-darwin = inputs.nixpkgs.lib.lists.unique (builtins.attrNames hostNames-darwin);

    userNames = {
      dell = "seb";
      nuc = "nuc";
      zima = "zima";
      workMac = "slopezsanchez";
      workWsl = "slopezsanchez";
      macAir = "seb";
    };

    systems = {
      dell = "x86_64-linux";
      nuc = "x86_64-linux";
      zima = "x86_64-linux";
      workWsl = "x86_64-linux";
      workMac = "aarch64-darwin";
      macAir = "aarch64-darwin";
    };

    supportedSystems = inputs.nixpkgs.lib.lists.unique (builtins.attrValues systems);

    overlay-unstable = system: final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    # As a module in system configurations - eg nix-darwin
    home-manager-defaults = user: hostName: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = {
          imports = [
            ./hosts/${hostName}/home.nix
            inputs.nixvim.homeManagerModules.nixvim
            { home.username = user; }
          ];
        };
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit user;
          host_alias = hostName;
        };
      };
    };

    # As a standalone config - eg ubuntu windows subsystem for linux
    mkConfig-homeManager = system: host: user:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          ./hosts/${host}/home.nix
          inputs.nixvim.homeManagerModules.nixvim
          { home.username = user; }
          {
            nixpkgs.config.permittedInsecurePackages = [
              "dotnet-sdk-6.0.428"
            ];
          }
        ];
        extraSpecialArgs = {
          inherit user;
          host_alias = host;
        };
      };

    mkConfig = name:
      inputs.nixpkgs.lib.nixosSystem {
        system = systems.${name};
        specialArgs = {
          inherit inputs;
          system = systems.${name};
          user = userNames.${name};
          host = hostNames.${name};
        };
        modules = [
          ./hosts/${name}
          {nixpkgs.overlays = [(overlay-unstable systems.${name})];}
          inputs.lollypops.nixosModules.lollypops
          inputs.home-manager.nixosModules.home-manager
          (home-manager-defaults userNames.${name} hostNames.${name})
        ];
      };

    mkConfig-darwin = name:
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          system = systems.${name};
          user = userNames.${name};
          host = hostNames.${name};
          inherit name;
        };
        modules = [
          ./hosts/${name}
          {nixpkgs.overlays = [(overlay-unstable systems.${name})];}
          inputs.home-manager.darwinModules.home-manager
          (home-manager-defaults userNames.${name} name)
          {
            nixpkgs.config.permittedInsecurePackages = [
              "dotnet-sdk-6.0.428"
            ];
          }
        ];
      };

    inherit (inputs.nixpkgs) lib;
  in {
    nixosConfigurations = lib.genAttrs hostAliases (
      host:
        mkConfig "${host}"
    );

    darwinConfigurations = lib.genAttrs hostAliases-darwin (
      host:
        mkConfig-darwin "${host}"
    );

    homeConfigurations = lib.genAttrs (hostAliases ++ hostAliases-darwin) (
      host: mkConfig-homeManager "${systems.${host}}" "${host}" "${userNames.${host}}"
    );

    # Expose the package set, including overlays, for convenience.
    darwinPackages = inputs.self.darwinConfigurations."workMac".pkgs; # across all darwin configs

    # lollypops devops for remote deployment
    apps = lib.genAttrs supportedSystems (
      system: {default = inputs.lollypops.apps.${system}.default {configFlake = inputs.self;};}
    );

    formatter = {
      x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
      aarch64-darwin = inputs.nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    };
  };
}
