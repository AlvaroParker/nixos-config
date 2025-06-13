{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./../base.nix ];

  environment.systemPackages = with pkgs; [
    sbctl
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    intel-compute-runtime # For OpenCL on Intel GPUs
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ vpl-gpu-rt intel-vaapi-driver ];
  };

  console.font = "ter-i32b";
  console.packages = with pkgs; [ terminus_font ];
  console.earlySetup = true;
}
