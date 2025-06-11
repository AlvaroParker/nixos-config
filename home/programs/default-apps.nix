{ ... }: {
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web browser
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "text/html" = "zen-beta.desktop";

      # Image viewer
      "image/jpeg" = "feh.desktop";
      "image/png" = "feh.desktop";
      "image/gif" = "feh.desktop";

      # PDF viewer
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };
}
