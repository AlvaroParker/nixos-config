{ ... }: {
  imports = [ ./hardware-configuration.nix ./../base.nix ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  boot.loader.systemd-boot.enable = true;
}
