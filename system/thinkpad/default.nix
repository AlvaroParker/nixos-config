{ pkgs, lib, lanzaboote, ... }: {
  imports = [ ./hardware-configuration.nix ./../base.nix ];

  environment.systemPackages = with pkgs; [ sbctl ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
