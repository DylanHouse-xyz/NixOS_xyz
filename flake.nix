{

  description = " Dylan's Flake";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nvf.url = "github:notashelf/nvf";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Ensures same version
  };

  outputs = { self, nixpkgs, nvf, home-manager, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    packages.system.default =
      (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./modules/nvf-configuration.nix ];
      }).neovim;

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [
          nvf.nixosModules.default 
          ./configuration.nix 
         ];
      };
    };
    homeConfigurations = {
    dylan = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
     };
   };
 };
}
