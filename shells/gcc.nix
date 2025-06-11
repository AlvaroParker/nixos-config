{ pkgs, ... }:

pkgs.mkShell {
  name = "gcc-shell";
  buildInputs = with pkgs; [ gcc gnumake cmake pkg-config valgrind gdb ninja ];
}
