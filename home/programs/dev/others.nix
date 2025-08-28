{ pkgs, unstable, inputs, ... }:
let pwndbg = inputs.pwndbg.packages.${pkgs.system}.default;
in {
  home.packages = with pkgs; [
    unstable.zed-editor
    nixfmt-classic
    nixd
    nil
    rustup
    cargo-generate
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
    github-desktop
    pwndbg
    android-studio
    watchman
    prismlauncher

    racket
    ghc
    haskell-language-server

    glab

    unstable.gleam
    erlang
    beam27Packages.erlang-ls

    deno
    yarn

    ruby
    rbenv
    solargraph

    basedpyright
    dua

    unstable.sniffnet
  ];

  programs.lazygit.enable = true;
  programs.ssh = { enable = true; };
  programs.television = { enable = true; };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.jq = { enable = true; };
  programs.vscode = { enable = true; };
  programs.ripgrep = { enable = true; };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = { enable = true; };
  };

  programs.nushell = { enable = true; };
}
