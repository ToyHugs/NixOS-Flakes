{
  description = "ToyHugs NixOS configuration with flakes";

  # Inputs are the dependencies of our flake
  inputs = {

    # Nixpkgs stable : for the stable packages and NixOS configuration
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Nixpkgs-unstable, for some applications requiring more recent versions
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  
    # Nix Alien, for installing packages from other distributions
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Home-manager, for managing my system configuration, such as themes, keyboard shortcuts, etc.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # To use the same version of nixpkgs
                                          # and avoid version conflicts or duplicates
    };

  };

  # The outputs are the derivations we want to build  
  outputs = { self, nixpkgs, nix-alien, ... } @ inputs: 
  let

    # Shortcut variable
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;

  in 
  {

    # To configure my system
    nixosConfigurations.default = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self system; };
      modules = [
        ./hosts/default/configuration.nix
        ./modules/nix-alien.nix
      ];
      
    };

  };
}
