{ pkgs, inputs, ... }:
let pwndbg = inputs.pwndbg.packages.${pkgs.system}.default;
in {

  home.packages = with pkgs; [
    nixfmt-classic
    nixd
    nil
    rustup
    clang
    clang-tools
    cmake
    gnumake
    nodejs
    docker-compose
    go
    unzip
    openjdk
    (pkgs.python3.withPackages
      (python-pkgs: [ python-pkgs.pandas python-pkgs.requests ]))

    google-chrome
    firefox-devedition
    firefox
    github-desktop
    pwndbg
    android-studio
    watchman
    prismlauncher
  ];

  programs.jq = { enable = true; };
  programs.zed-editor = { enable = true; };
  programs.vscode = { enable = true; };
  programs.ripgrep = { enable = true; };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = { enable = true; };
  };
}
