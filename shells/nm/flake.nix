{
  description = "Dev shell for Network Manager";

  inputs = { nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.05"; }; };

  outputs = { nixpkgs, ... }: {
    devShells.x86_64-linux.default = let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in pkgs.mkShell {
      name = "nm-shell";

      buildInputs = with pkgs; [
        dbus
        libndp
        elogind
        jansson
        libselinux
        audit
        polkit
        nss
        gnutls
        ppp
        modemmanager
        mobile-broadband-provider-info
        libpsl
        curl
        dnsmasq
        libedit
        newt
        libnvme
        libxslt
        (pkgs.python3.withPackages (python-pkgs: [ python-pkgs.pygobject3 ]))
        # Docs    meson
        gettext
        vala
        gobject-introspection
        perl
        elfutils # used to find jansson soname
        # Docs
        gtk-doc
        libxslt
        docbook_xsl
        docbook_xml_dtd_412
        docbook_xml_dtd_42
        docbook_xml_dtd_43

        util-linux
        ncurses
        gcc
        gnumake
        pkg-config
        ninja
        meson
        glib
        gusb
        cairo
        pixman
        openssl
        libgudev
        valgrind
        gdb
        appstream
        python3
        readline
      ];

      packages = with pkgs; [ pkgs.readline pkg-config ];

      shellHook = "";
    };
  };
}
