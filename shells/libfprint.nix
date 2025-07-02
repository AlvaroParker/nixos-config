{ pkgs, ... }:

pkgs.mkShell {
  name = "libfprint-shell";
  buildInputs = with pkgs; [ gcc gnumake pkg-config gdb ninja meson ];
}
