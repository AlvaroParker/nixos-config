{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = with pkgs; [ texlive.combined.scheme-full inotify-tools ];
}
