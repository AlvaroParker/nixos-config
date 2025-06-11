{
  description = "Dev shell for halloy";

  inputs = { nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.05"; }; };

  outputs = { nixpkgs, ... }: {
    devShells.x86_64-linux.default = let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in pkgs.mkShell {
      name = "halloy-shell";

      buildInputs = with pkgs; [
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

      packages = with pkgs; [
        pkgs.readline
        pkg-config
        autoconf
        gettext
        slang
        popt
        bear
      ];

      shellHook = "";
    };
  };
}
