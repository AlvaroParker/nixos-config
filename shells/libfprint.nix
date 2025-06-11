{ pkgs, ... }:

pkgs.mkShell {
  name = "libfprint-shell";
  buildInputs = with pkgs; [
    gcc
    gnumake
    pkg-config
    ninja
    meson
    glib
    gusb
    mathlibtools
    gobject-introspection
    cairo
    pixman
    openssl
    libgudev
    gtk-doc
    valgrind
    gdb
    appstream
    python3
  ];
}
