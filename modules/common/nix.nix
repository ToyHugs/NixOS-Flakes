{ lib, ... }: {
  # Enable modern CLI and flakes for all hosts.
  nix.settings.experimental-features = lib.mkAfter [ "nix-command" "flakes" ];

  # Reasonable store/GC defaults.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;
}
