{ pkgs, ... }: {

  home.packages = with pkgs; [
    nixfmt-classic
    nixd
    nil
    rustup
    gcc
    nodejs
    docker-compose
    (pkgs.python3.withPackages
      (python-pkgs: [ python-pkgs.pandas python-pkgs.requests ]))

    google-chrome
    firefox-devedition
    firefox
  ];
  programs.zed-editor = { enable = true; };
  programs.vscode = { enable = true; };
  programs.ripgrep = { enable = true; };
}
