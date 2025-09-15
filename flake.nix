{
  description =
    "Modular NixOS flake with Home Manager, multi-host & multi-user profile composition";

  inputs = {
    nixpkgs-24-11.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    # Keep HM locked to 24.11 inputs to avoid an extra lock; HM will still use the host pkgs via useGlobalPkgs
    home-manager.inputs.nixpkgs.follows = "nixpkgs-24-11";
  };

  outputs = inputs@{ self, nixpkgs-24-11, nixpkgs-unstable, home-manager, ... }:
    let mkHost = import ./lib/mkHost.nix { inherit inputs self home-manager; };
    in {
      nixosConfigurations = {
        # Desktop host pinned to 24.11
        gnome = mkHost {
          nixpkgs = nixpkgs-24-11;
          system = "x86_64-linux";
          hostName = "gnome";
          extraSpecialArgs = {
            # Optional: expose an unstable set to profiles/HM if needed
            pkgsUnstable = import nixpkgs-unstable { system = "x86_64-linux"; };
          };
        };

        # Server host pinned to unstable
        tests = mkHost {
          nixpkgs = nixpkgs-24-11;
          system = "x86_64-linux";
          hostName = "tests";
          extraSpecialArgs = {
            # Optional: expose an unstable set to profiles/HM if needed
            pkgsUnstable = import nixpkgs-unstable { system = "x86_64-linux"; };
          };
        };
      };
    };
}
