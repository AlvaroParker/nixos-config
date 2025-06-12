{ ... }: {
  imports = [ ./hardware-configuration.nix ./../base.nix ];
  boot.loader.systemd-boot.enable = true;
}
