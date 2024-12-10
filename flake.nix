{
  description = "A ToyHugs Flake";

  # Les entrées sont les dépôts que nous voulons utiliser pour construire notre système
  inputs = {

    # Nixpkgs stable, pour presque tout les paquets de mon système
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Nixpkgs unstable, pour certaines applications nécessitant des versions plus récentes
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home-manager, pour gérer la configuration de mon système, comme les thèmes, les raccourcis clavier, etc.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Pour utiliser la même version de nixpkgs
                                          # et éviter un conflit de version ou doublon
    };

  };

  # Les sorties sont les dérivations que nous voulons construire
  outputs = { self, nixpkgs, ... } @ inputs: 
  let

    # Variable de raccourci
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;

  in 
  {

    # Configuration de mon système
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./config/configuration.nix
      ];
    };
    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = pkgs.hello;

  };
}
