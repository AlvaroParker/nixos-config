{ pkgs, lib, unstable, ... }@args: {
  imports = [ ./hardware-configuration.nix ./../base.nix ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking.hosts = args.servers;

  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [ sbctl ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.initrd.kernelModules = [ "xe" ];

  boot.kernelParams = [ "snd_hda_intel.dmic_detect=0" ];

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1 report_ignored_msrs=0
  '';

  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.wireplumber.enable = true;
  hardware.bluetooth.package = pkgs.bluez;
  hardware.bluetooth.settings = { General = { Experimental = true; }; };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ vpl-gpu-rt intel-media-driver ];
  };

  console.font = "ter-i32b";
  console.packages = with pkgs; [ terminus_font ];
  console.earlySetup = true;

  # Enable nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
      xorg.libxcb
      libxkbcommon
      libbsd
      alsa-lib
      xorg.libXau
      xorg.libXdmcp
      zstd
      wayland
      vulkan-loader
      xkeyboard_config
    ];
  };

  environment.variables = {
    XKB_CONFIG_ROOT = "${pkgs.xkeyboard_config}/share/X11/xkb/";
  };
  services.tailscale = {
    enable = true;
    package = unstable.tailscale;
  };

  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
