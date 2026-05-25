{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    hyprland = {
#      url = "github:hyprwm/Hyprland";
#      inputs.nixpkgs.follows = "nixpkgs"; # fixed typo
#    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    mango,
#    hyprland,
    ...
  }: {
    nixosConfigurations.t440p = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration.nix

#        hyprland.nixosModules.default

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            users.piffytu = {
              imports = [
                mango.hmModules.mango
                ./home.nix
              ];
            };
          };
        }
      ];
    };
  };
}
