{
  description = "ToyHugs NixOS configuration with flakes";

  # Inputs are the dependencies of our flake
  inputs = {

    # Nixpkgs stable : for the stable packages and NixOS configuration
    nixpkgs-24-11.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-25-05.url = "github:nixos/nixpkgs/nixos-25.05";

    # Nixpkgs-unstable, for some applications requiring more recent versions
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  
    # Nix Alien, for installing packages from other distributions
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Home-manager, for managing my system configuration, such as themes, keyboard shortcuts, etc.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-24-11"; # To use the same version of nixpkgs
                                                # and avoid version conflicts or duplicates
    };

  };

  # The outputs are the derivations we want to build  
  outputs = { self, nixpkgs-24-11, nix-alien, ... } @ inputs: 
  let

    # Shortcut variable
    pkgs-24-11 = inputs.nixpkgs-24-11.legacyPackages.x86_64-linux;  # Updated to use the new nixpkgs input
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;

  in 
  {

    # To configure my system
    nixosConfigurations.gnome = let pkgs = pkgs-24-11; in nixpkgs-24-11.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self system; };
      modules = [
        ./hosts/gnome/configuration.nix
        ./modules/nix-alien.nix
      ];
      
    };

  };
}
