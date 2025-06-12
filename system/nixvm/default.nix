{ pkgs, ... }@args:

{
  imports = [
    ./hardware-configuration.nix
    ./../base.nix
  ];

}
