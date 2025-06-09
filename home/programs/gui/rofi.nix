{ pkgs, ... }: {
  home.file.".config/rofi" = {
    source = ./config/rofi;
    recursive = true;
  };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "mocha-icons";
    extraConfig = {
      normalize-match = true;
      show-icons = true;
      icon-theme = "Reversal-dark";
      fallback-icon = "application-x-addon";
      display-drun = "";
      terminal = "alacritty";
      font = "Inter V 12";
    };
  };
}
