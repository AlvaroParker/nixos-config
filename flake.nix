{
  description = "NixOS configuration for Parker's laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg.url = "github:pwndbg/pwndbg";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, lanzaboote, pwndbg, unstable, ... }@inputs:
    let
      vars = import ./vars.nix;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      unstablePkgs = import unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (vars)
            username nickName email homeDirectory hostname timezone servers
            defaultLocale;
          inherit inputs;
          unstable = unstablePkgs;
        };
        modules = [
          lanzaboote.nixosModules.lanzaboote

          ./system/${vars.hostname}
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.android_sdk.accept_license = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home;
            home-manager.extraSpecialArgs = {
              inherit (vars)
                username nickName fullName email homeDirectory ssh_public
                batteryName;
              inherit inputs;
              unstable = unstablePkgs;
            };
          }
        ];
      };
      devShells.${system} = {
        nodejs = import ./shells/nodejs.nix { inherit pkgs; };
        gcc = import ./shells/gcc.nix { inherit pkgs; };
        libfprint = import ./shells/libfprint.nix { inherit pkgs; };
        latex = import ./shells/latex.nix { inherit pkgs; };
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
