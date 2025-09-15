# Helper that builds a NixOS system with Home Manager integrated and shared defaults.
{ inputs, self, home-manager }:
{ nixpkgs, system, hostName, modules ? [ ], extraSpecialArgs ? { } }:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs self system; } // extraSpecialArgs;
  modules = [
    # Common cross-host defaults
    ./../modules/common/nix.nix
    ./../modules/common/locale.nix

    # Integrate Home Manager into NixOS activation
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true; # HM uses the same pkgs as the host
      home-manager.useUserPackages =
        true; # Install HM packages into the user's profile
    }

    # Set hostname centrally
    ({ ... }: { networking.hostName = hostName; })
  ] ++ modules
    # Import the host-specific configuration at the very end
    ++ [ (self + "/hosts/${hostName}/configuration.nix") ];
}
