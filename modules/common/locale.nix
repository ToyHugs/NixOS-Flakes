{ ... }:
{
  # System-wide locale/timezone defaults (adjust per host if needed).
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
  };
}
