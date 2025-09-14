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
      inputs.nixpkgs.follows =
        "nixpkgs-24-11"; # To use the same version of nixpkgs
      # and avoid version conflicts or duplicates
    };

  };

  # The outputs are the derivations we want to build  

  outputs = inputs@{ self, nixpkgs-24-11, nixpkgs-unstable, nix-alien, ... }:
    let
      # A function to create a NixOS system configuration for a given host
      mkHost =
        { nixpkgs, system ? "x86_64-linux", modules, extraSpecialArgs ? { } }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self system; } // extraSpecialArgs;
          modules = modules ++ [
            # Default configuration for all hosts
            ({ ... }: {
              nixpkgs.hostPlatform = system;
              # nixpkgs.config.allowUnfree = true;
              # nixpkgs.overlays = [ ];
            })
          ];
        };
    in {
      # Define the NixOS configurations for each host
      nixosConfigurations = {
        # Host GNOME, pinned on 24.11 stable
        gnome = mkHost {
          nixpkgs = nixpkgs-24-11;
          modules = [
            ./hosts/gnome/configuration.nix

            # If you want to use nix-alien, and it exposes a flake module :
            # nix-alien.nixosModules.default
            ./modules/nix-alien.nix
          ];
          # Expose an unstable set of packages if you want to use some from there occasionally
          extraSpecialArgs = {
            pkgsUnstable = import nixpkgs-unstable { system = "x86_64-linux"; };
          };
        };

        # Another example host
        # server = mkHost {
        #   nixpkgs = nixpkgs-24-11;
        #   modules = [ ./hosts/server/configuration.nix ];
        # };

        mona = mkHost {
          nixpkgs = nixpkgs-24-11;
          modules = [
            ./hosts/mona/configuration.nix
          ];
        }

      };
    };

}
