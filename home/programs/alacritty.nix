{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.sauce-code-pro
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        indexed_colors = [
          {
            index = 16;
            color = "#FAB387";
          }
          {
            index = 17;
            color = "#F5E0DC";
          }
        ];
        bright = {
          black = "#585B70";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#6C9EE6";  # Darker, more readable blue
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#E6E9EF";  # Brighter, more readable white
        };
        dim = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#5A8BD4";  # Even darker blue for dim variant
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#D4D7DD";  # Slightly dimmed white
        };
        normal = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#6C9EE6";  # Same as bright blue for consistency
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#D4D7DD";  # Good contrast white for normal use
        };
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          bright_foreground = "#CDD6F4";
          dim_foreground = "#CDD6F4";
        };
        cursor = {
          cursor = "#F5E0DC";
          text = "#1E1E2E";
        };
        vi_mode_cursor = {
          cursor = "#B4BEFE";
          text = "#1E1E2E";
        };
        selection = {
          background = "#F5E0DC";
          text = "#1E1E2E";
        };
        search = {
          matches = {
            background = "#A6ADC8";
            foreground = "#1E1E2E";
          };
          focused_match = {
            background = "#A6E3A1";
            foreground = "#1E1E2E";
          };
        };
        hints = {
          start = {
            background = "#F9E2AF";
            foreground = "#1E1E2E";
          };
          end = {
            background = "#A6ADC8";
            foreground = "#1E1E2E";
          };
        };
      };
      cursor = {
        style = {
          shape = "Block";
          blinking = "Always";
        };
        blink_interval = 450;
        blink_timeout = 0;
        unfocused_hollow = false;
      };
      env = { TERM = "xterm-256color"; };
      font = {
        size = 10;
        normal = {
          family = "FiraCode Nerd Font";
          style = "SemiBold";
        };
        offset = {
          x = 0;
          y = 0;
        };
      };
      window = {
        opacity = 0.6;
        dimensions = {
          columns = 106;
          lines = 26;
        };
        padding = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
