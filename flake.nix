{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    lollypops.url = "github:pinpox/lollypops";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:

  let

    hostNames = {
      dell = "dell";
      nuc = "nuc";
      zima = "zima";
    };

    hostAliases = inputs.nixpkgs.lib.lists.unique (builtins.attrNames hostNames);

    hostNames-darwin = {
      workMac =  "LUSHQF0X7F3GW";
    };

    hostAliases-darwin = inputs.nixpkgs.lib.lists.unique (builtins.attrNames hostNames-darwin);

    userNames = {
      dell = "seb";
      nuc = "nuc";
      zima = "zima";
      workMac = "slopezsanchez";
    };

    systems = {
      dell = "x86_64-linux";
      nuc = "x86_64-linux";
      zima = "x86_64-linux";
      workMac = "aarch64-darwin";
    };

    supportedSystems = inputs.nixpkgs.lib.lists.unique (builtins.attrValues systems);

    overlay-unstable = system: final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };
    };

    home-manager-defaults = user: name: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = {
          imports = [
            ./hosts/${name}/home.nix
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };
        backupFileExtension = "backup";
        extraSpecialArgs = {
          user = user;
          host_alias = name; # name is a reserved keyword
        };
      };
    };

    mkConfig = name: inputs.nixpkgs.lib.nixosSystem {
      system = systems.${name};
      specialArgs = {
        inherit inputs;
        system = systems.${name};
        user = userNames.${name};
        host = hostNames.${name};
      };
      modules = [
        ./hosts/${name}
        { nixpkgs.overlays = [ (overlay-unstable systems.${name}) ]; }
        inputs.lollypops.nixosModules.lollypops
        inputs.home-manager.nixosModules.home-manager
        (home-manager-defaults userNames.${name} hostNames.${name})
      ];
    };

    mkConfig-darwin = name: inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
        system = systems.${name};
        user = userNames.${name};
        host = hostNames.${name};
        name = name;
      };
      modules = [
        ./hosts/${name}
        { nixpkgs.overlays = [ (overlay-unstable systems.${name}) ]; }
        inputs.home-manager.darwinModules.home-manager
        (home-manager-defaults userNames.${name} name)
      ];
    };


  in {

    nixosConfigurations = inputs.nixpkgs.lib.genAttrs hostAliases (host:
      mkConfig "${host}"
    );

    # $ darwin-rebuild build --flake .#LUSHQF0X7F3GW
    darwinConfigurations = inputs.nixpkgs.lib.genAttrs hostAliases-darwin (host:
      mkConfig-darwin "${host}"
    );

    # Expose the package set, including overlays, for convenience.
    darwinPackages = inputs.self.darwinConfigurations."workMac".pkgs;

    # lollypops devops for remote deployment
    apps = inputs.nixpkgs.lib.genAttrs supportedSystems (system:
      { default = inputs.lollypops.apps.${system}.default { configFlake = inputs.self; }; }
    );
  };
}
