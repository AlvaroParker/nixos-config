{ pkgs, unstable, inputs, ... }: {
  home.packages = with pkgs; [
    discord
    pavucontrol
    feh
    vlc
    ranger
    inter
    playerctl

    # Screenshot
    wl-clipboard
    libnotify
    grim
    slurp

    # Software
    stremio
    obsidian
    libreoffice
    obs-studio
    spotify
    inkscape

    authenticator
    wdisplays
    postman
    # ventoy # not trusted
    gdm-settings
    scrcpy

    inputs.zen-browser.packages."${system}".default

    # For yazi
    mediainfo
    ueberzugpp
    exiftool

    shellcheck
    shfmt

    authenticator

    obsidian
    unstable.ollama
    check-jsonschema
    perl

    unstable.claude-code
    unstable.gemini-cli

    caddy
    halloy
    scrcpy

    brave
    gnome-solanum
  ];

  xdg.desktopEntries = {
    discord-wayland = {
      name = "Discord (Wayland)";
      genericName = "Internet Messenger";
      comment =
        "All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.";
      exec =
        "/etc/profiles/per-user/parker/bin/discord --ozone-platform-hint=auto";
      icon = "discord";
      type = "Application";
      categories = [ "Network" "InstantMessaging" ];
    };

    obsidian-wayland = {
      categories = [ "Office" ];
      comment = "Knowledge base";
      exec =
        "/etc/profiles/per-user/parker/bin/obsidian  --ozone-platform-hint=auto";
      icon = "obsidian";
      mimeType = [ "x-scheme-handler/obsidian" ];
      name = "Obsidian (Wayland)";
      type = "Application";
    };
  };

  services.clipse.enable = true;

  home.file.".local/bin/auto_tmux" = {
    source = ./bin/auto_tmux;
    executable = true;
  };

  programs.thunderbird = {
    enable = true;
    profiles = { default = { isDefault = true; }; };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener = {
        play = [{
          run = ''vlc \"$@\"'';
          desc = "VLC";
          orphan = true;
        }];
      };
    };
  };

  programs.zellij = { enable = true; };

  programs.zathura = {
    enable = true;
    mappings = {
      "<C-i>" = "zoom in";
      "<C-o>" = "zoom out";
    };
    options = {
      default-fg = "#CDD6F4";
      default-bg = "#1E1E2E";

      completion-bg = "#313244";
      completion-fg = "#CDD6F4";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#CDD6F4";
      completion-group-bg = "#313244";
      completion-group-fg = "#89B4FA";

      statusbar-fg = "#CDD6F4";
      statusbar-bg = "#313244";

      notification-bg = "#313244";
      notification-fg = "#CDD6F4";
      notification-error-bg = "#313244";
      notification-error-fg = "#F38BA8";
      notification-warning-bg = "#313244";
      notification-warning-fg = "#FAE3B0";

      inputbar-fg = "#CDD6F4";
      inputbar-bg = "#313244";

      recolor-lightcolor = "#1E1E2E";
      recolor-darkcolor = "#CDD6F4";

      index-fg = "#CDD6F4";
      index-bg = "#1E1E2E";
      index-active-fg = "#CDD6F4";
      index-active-bg = "#313244";

      render-loading-bg = "#1E1E2E";
      render-loading-fg = "#CDD6F4";

      highlight-color = "#575268";
      highlight-fg = "#F5C2E7";
      highlight-active-color = "#F5C2E7";

      recolor = true;
      recolor-keephue = true;
    };
  };
}
