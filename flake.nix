{
  description = " Dylan's main Flake file.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; # Unstable channel
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvf.url = "github:notashelf/nvf";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Ensures same version
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nvf,
    home-manager,
    zen-browser,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
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
          inherit inputs;
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
