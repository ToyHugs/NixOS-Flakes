{ lib, self, ... }:
# User-as-a-module: create the account and select Home Manager profiles.
let
P = import ../../lib/registry.nix { inherit self lib; };
name = "pierre";
homeDir = "/home/${name}";
stateVersion = "24.11"; # HM state version for migrations
in
{
# System account (no machine specifics here beyond generic groups)
users.users.${name} = {
isNormalUser = true;
description = "${name}";
extraGroups = [ "wheel" "networkmanager" ];
shell = "/run/current-system/sw/bin/zsh";
};


# Home Manager profile selection for this user
home-manager.users.${name} = {
imports = P.pick [ "dev" "desktop" ] P.hm;
home.stateVersion = stateVersion;
home.username = name;
home.homeDirectory = homeDir;
};
}