{ pkgs, ... }: {
  # Base building blocks shared by most hosts.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.useNetworkManager = true;
  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [ vim htop git curl wget gnupg ];

  # Lock the NixOS option schema for this install (adjust on new installs only).
  system.stateVersion = "24.11";
}
