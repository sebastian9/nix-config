{
  description = "Seb's Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    lollypops.url = "github:pinpox/lollypops";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
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
      # workMac = "LUSHQF0X7F3GW";
    };

    hostAliases = inputs.nixpkgs.lib.lists.unique (builtins.attrNames hostNames);

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

    home-manager-defaults = user: host: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ./hosts/${host}/home.nix;
      home-manager.backupFileExtension = "backup";
      home-manager.extraSpecialArgs = {
        user = user;
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


    nix_darwin_config = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
          vim
          fzf
          zoxide
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };

  in {

    nixosConfigurations = inputs.nixpkgs.lib.genAttrs hostAliases (host:
      mkConfig "${host}"
    );

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#LUSHQF0X7F3GW
    darwinConfigurations."LUSHQF0X7F3GW" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."LUSHQF0X7F3GW".pkgs;

    # lollypops devops for remote deployment
    apps = inputs.nixpkgs.lib.genAttrs supportedSystems (system:
      { default = inputs.lollypops.apps.${system}.default { configFlake = inputs.self; }; }
    );
  };
}
