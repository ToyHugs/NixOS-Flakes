# Central registry mapping profile names to module paths, plus a tiny picker.
{ self, lib }:
let
  sys = {
    base = self + "/profiles/system/base.nix";
    desktop-gnome = self + "/profiles/system/desktop-gnome.nix";
    docker = self + "/profiles/system/docker.nix";
    virtualization = self + "/profiles/system/virtualization.nix";
  };

  apps = {
    dev-cli = self + "/profiles/apps/dev-cli.nix";
    media = self + "/profiles/apps/media.nix";
    gaming = self + "/profiles/apps/gaming.nix";
  };

  hm = {
    dev = self + "/hm/profiles/dev.nix";
    desktop = self + "/hm/profiles/desktop.nix";
  };

  pick = names: registry: map (n: lib.getAttr n registry) names;
in { inherit sys apps hm pick; }
