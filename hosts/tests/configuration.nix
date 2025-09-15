{ lib, self, ... }:
# Host composition: pick system/app profiles and bind parametric options.
let
P = import ../../lib/registry.nix { inherit self lib; };
in
{
imports =
[
./hardware-configuration.nix
]
# System role bundles for this host
++ (P.pick [ "base" "desktop-gnome" "docker" ] P.sys)
# App bundles for this host
++ (P.pick [ "dev-cli" ] P.apps)
# Users instantiated on this host
++ [ ../../users/pierre ];


# Bind virtualization group members for this machine (no names in the profile itself)
my.virtualization.users = [ "pierre" ];
}