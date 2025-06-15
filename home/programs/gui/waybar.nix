{ pkgs, batteryName, ... }: {
  home.file.".config/waybar/scripts/caway" = {
    source = ./config/waybar/scripts/caway;
    executable = true;
  };

  programs.cava.enable = true;

  programs.waybar = {
    enable = true;
    systemd.enable = false;
    style = pkgs.lib.readFile ./config/waybar/style.css;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      margin-top = 2;
      margin-left = 2;
      marign-right = 2;
      margin-bottom = 5;
      spacing = 8;

      modules-left =
        [ "custom/launcher" "cpu" "memory" "custom/window-name" "tray" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "battery" "backlight" "pulseaudio" "network" "clock" ];
      "custom/launcher" = {
        format = "";
        on-click = "rofi -show drun";
      };

      cpu = {
        interval = 5;
        format = " {usage}%";
        max-length = 10;
        tooltip = false;
      };
      memory = {
        interval = 30;
        format = " {used}GiB";
        format-alt = " {used:0.1f}G";
        max-length = 10;
      };
      "custom/window-name" = {
        format = "<b>{}</b>";
        interval = 1;
        exec =
          "hyprctl activewindow | grep \"class:\" | awk '{print $2}' | sed 's/\\([[:alpha:]]\\)/\\U\\1/'";
      };
      tray = {
        icon-size = 20;
        spacing = 8;
      };

      "hyprland/workspaces" = {
        all-outputs = true;
        active-only = false;
        on-click = "activate";
        format = "{icon}";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
      };
      "custom/music" = {
        format = "{}";
        exec = "$HOME/.config/waybar/scripts/caway";
        on-click = "playerctl play-pause";
      };
      battery = {
        bat = "${batteryName}";
        interval = 30;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {icon} {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        max-length = 25;
        tooltip = false;
      };
      backlight = {
        format = "{icon} {percent}";
        tooltip = false;
        format-icons = [ "󰃚 " "󰃛 " "󰃜 " "󰃝 " "󰃞 " "󰃟 " "󰃠 " ];
      };
      pulseaudio = {
        format = "{icon} <b>{volume}</b>";
        format-bluetooth = " <b>{volume}</b>";
        format-bluetooth-muted = " ";
        tooltip = false;
        format-muted = " ";
        format-icons = { default = [ "󰕿 " "󰖀 " "󰕾 " ]; };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "  {essid}";
        on-click = "iwgtk";
        format-ethernet = "󰈀 wired";
        tooltip = false;
        format-disconnected = "󰖪";
      };
      clock = {
        interval = 1;
        format = "󱑅 <b>{:%I:%M:%S %p}</b>";
        format-alt = "󱑅 <b>{:%a.%d,%b}</b>";
        tooltip-format = ''
          <big>{:%B %Y}</big>
          <tt><small>{calendar}</small></tt>'';
      };
    }];
    # settings = pkgs.lib.readFile ./config/waybar/config.jsonc;
  };

}
