{
  description = "NixOS configuration for Parker's laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs:
    let vars = import ./vars.nix;
    in {
      nixosConfigurations.nixvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (vars)
            username nickName email homeDirectory hostname timezone
            defaultLocale;
          inherit inputs;
        };
        modules = [
          ./system/nixvm
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home;
            home-manager.extraSpecialArgs = {
              inherit (vars)
                username nickName fullName email homeDirectory ssh_public
                batteryName;
              inherit inputs;
            };
          }
        ];
      };

      nixosConfigurations.huawei = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (vars)
            username nickName email homeDirectory hostname timezone
            defaultLocale;
          inherit inputs;
        };
        modules = [
          ./system/huawei
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home;
            home-manager.extraSpecialArgs = {
              inherit (vars)
                username nickName fullName email homeDirectory ssh_public
                batteryName;
              inherit inputs;
            };
          }
        ];
      };

      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (vars)
            username nickName email homeDirectory hostname timezone
            defaultLocale;
          inherit inputs;
        };
        modules = [
          ./system/thinkpad
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = import ./home;
            home-manager.extraSpecialArgs = {
              inherit (vars)
                username nickName fullName email homeDirectory ssh_public
                batteryName;
              inherit inputs;
            };
          }
        ];
      };
    };
}
