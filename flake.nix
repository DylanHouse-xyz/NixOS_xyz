{
  description = " Dylan's main Flake file.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; # Unstable channel
    nvf.url = "github:notashelf/nvf";
    helium.url = "github:AlvaroParker/helium-nix";
    helium.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Ensures same version
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nvf,
    home-manager,
    helium,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    #pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnFree = true;
        permittedInsecurePackages = [
          "electron-41.10.6"
        ];
      };
    };
  in {
    packages.${system}.default =
      (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          ./modules/Neovim/nvf.nix
          ./modules/Neovim/keymaps.nix
        ];
      }).neovim;

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit helium;
          inherit pkgs-unstable;
        };
        modules = [
          nvf.nixosModules.default
          ./configuration.nix
        ];
      };
    };
    homeConfigurations = {
      dylan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
        modules = [./home.nix];
      };
    };
  };
}
