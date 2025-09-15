{ lib, config, ... }:
let
  # Option describing which users should be added to virtualization groups.
  usersOpt = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description =
      "Users to add to virtualization-related groups (libvirtd, kvm).";
  };
in {
  options.my.virtualization.users = usersOpt;

  config = {
    # Atomic capability: enable libvirt and virt-manager.
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # Bind users at the *assembly* layer (hosts) via the option above.
    users.groups.libvirtd.members = lib.mkAfter config.my.virtualization.users;
    users.groups.kvm.members = lib.mkAfter config.my.virtualization.users;
  };
}
