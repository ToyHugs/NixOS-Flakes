{ config, lib, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader configuration
  boot.loader = {

    systemd-boot.enable = false; # Disable to use GRUB
    efi.canTouchEfiVariables = true;

    # GRUB as boot loader.
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      #gfxmodeEfi = "auto";
    };
  };

  # Networking configuration
  networking = {
    hostName = "mona";
    networkmanager.enable = true;
    # wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };

  # Localisation and internationalisation settings.
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_NUMERIC = "fr_FR.UTF-8"; # For number formatting (e.g., 1 234,56)
      LC_TIME = "fr_FR.UTF-8"; # For time formatting (e.g., 12:34:56)
    };
  };

  # Windows Manager and Desktop Environment configuration

  # services.wa

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.toyhugs = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    hashedPassword = "$7$CU..../....e5Y/VWPEmPW7neU9QZVQ1.$9LGG9i0yxhmkLeYM.EJ/KdM0QrmO3.iD.gAf9mUzTr3"; 
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion =
    "24.11"; # Never modify this value after installation! Get from `nixos-generate-config`

}

