rec {
  username = "parker";
  nickName = "Parker";
  fullName = "Alvaro Parker";
  email = "aparkerdf@protonmail.com";
  hostname = "thinkpad";
  homeDirectory = "/home/parker";
  ssh_public =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILzidMNYZJXNaK+lwC8T6i6U9J5arrSe1i3rHqPdaVWV ${username}@${hostname}";
  timezone = "America/Santiago";
  defaultLocale = "en_US.UTF-8";
  batteryName = "BAT0"; # Get it from `ls /sys/class/power_supply`
  servers = {
    "100.105.161.112" = [ "archserver" ];
    "100.127.196.66" = [ "labserver" ];
  };
}
