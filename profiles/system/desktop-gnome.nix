{ pkgs, ... }: {
  # GNOME desktop environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour  # GNOME Tour (intro for new users)
    epiphany # GNOME Web browser
    geary # GNOME Mail client
  ];
}
