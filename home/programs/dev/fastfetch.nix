{ ... }: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_old_small";
        color = {
          "1" = "bright_blue";
          "2" = "white";
        };
        padding = {
          top = 1;
          left = 3;
        };
      };
      display = { separator = " "; };

      modules = [
        {
          "type" = "custom";
          "format" = "{#35}╭──────────────────────────────────────────╮";
        }
        {
          "type" = "os";
          "key" = "{#35}│ {#34} ";
          "keyColor" = "blue";
        }
        {
          "type" = "kernel";
          "key" = "{#35}│ {#34} ";
          "keyColor" = "blue";
        }
        {
          "type" = "uptime";
          "key" = "{#35}│ {#34} ";
          "keyColor" = "blue";
        }
        {
          "type" = "shell";
          "key" = "{#35}│ {#34} ";
          "keyColor" = "blue";
        }
        {
          "type" = "wm";
          "key" = "{#35}│ {#34} ";
          "keyColor" = "blue";
        }
        {
          "type" = "memory";
          "key" = "{#35}│ {#34} ";
          "keyColor" = "blue";
        }
        {
          "type" = "cpu";
          "key" = "{#35}│ {#34}󰍛 ";
          "keyColor" = "blue";
          "format" = "{freq-max} - {cores-logical} cores {#34}";
        }
        {
          "type" = "custom";
          "format" =
            "{#35}╰───────────────────── {#90} {#31} {#32} {#33} {#34} {#35} {#36} {#37} {#35}────╯";
        }
      ];
    };
  };
}
