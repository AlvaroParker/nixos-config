{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    hyprpaper
    blueman
    networkmanagerapplet
    unstable.hyprsunset
    nwg-look
    hypridle

    bibata-cursors
    reversal-icon-theme

    unstable.hyprshade
  ];
  home.file.".config/hypr" = {
    source = ./config/hypr;
    recursive = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 22;
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
  gtk = {
    enable = true;
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };
  qt = {
    enable = true;
    platformTheme = { name = "adwaita"; };
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  wayland.windowManager.hyprland = {
    package = unstable.hyprland;
    enable = true;
    extraConfig = ''
      # RESIZE
      bind =$mainMod SHIFT,R,submap,resize # will switch to a submap called resize

      submap=resize # will start a submap called "resize"

      binde=,L,resizeactive,10 0
      binde=,H,resizeactive,-10 0
      binde=,K,resizeactive,0 -10
      binde=,J,resizeactive,0 10

      bind =,escape,submap,reset # use reset to go back to the global submap

      exec = hyprshade on $HOME/.config/hypr/saturation.glsl.mustache

      submap=reset # will reset the submap
    '';
    settings = {
      monitor = [
        "desc:Samsung Electric Company LS27C33xG H9TX400275, 1920x1080@100, auto, 1"
        " , preferred, auto, 1"
        "eDP-1, 3072x1920@120, 0x0,2, vrr, 1"
        "Virtual-1,1920x1080,auto,1"
      ];
      bindl = [
        ", switch:on:Lid Switch, exec, $HOME/.config/hypr/close_lid"
        ", switch:off:Lid Switch, exec, $HOME/.config/hypr/open_lid"
      ];
      "$mainMod" = "SUPER";
      xwayland = { force_zero_scaling = true; };
      ecosystem = { no_update_news = true; };
      misc = {
        disable_hyprland_logo = true;
        focus_on_activate = false;
        new_window_takes_over_fullscreen = true;
        splash_font_family = "Inter V";
        allow_session_lock_restore = true;
        enable_anr_dialog = false;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          tap-to-click = "yes";
        };
        sensitivity = 0;
        repeat_rate = 50;
        repeat_delay = 500;
      };

      general = {
        no_border_on_floating = false;
        gaps_in = 2.5;
        gaps_out = 10;
        # gaps_out = 2.5,2.5,2.5,2.5
        border_size = 3;

        # Catppuccin Mocha - Use "Lavender" and "Blue" for gradient
        # col.active_border = rgba(b4befeFF) rgba(89b4faFF) 100deg
        "col.active_border" =
          "rgba(b4befeFF) rgba(74c7ecFF) rgba(89b4faFF) 120deg";
        # Use "Surface0" for inactive border, with transparency
        "col.inactive_border" = "0x66313244";

        layout = "dwindle";
      };

      group = {
        "col.border_active" = "rgba(CAD3F5FF) rgba(4ABAAFFF) 50deg";
        "col.border_inactive" = "rgba(343A40FF)";
        # col.group_border_active=rgba(CAD3F5FF)
        groupbar = {
          gradients = false;
          render_titles = false;
          enabled = false;
          "col.inactive" = "rgba(343A40FF)";
          "col.active" = "rgba(CAD3F5FF) rgba(4ABAAFFF) 50deg";
        };
      };

      decoration = {
        rounding = 10;
        # multisample_edges=true

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          popups = true;
          size = 3;
          passes = 4; # minimum 1, more passes = more resource intensive.
          ignore_opacity = true;
        };

        # drop_shadow=true
        # shadow_range=10
        shadow = {
          enabled = true;
          range = 10;
          color = "rgba(9399B280)";
          color_inactive = "0x50000000";
        };
      };
      animations = {
        bezier =
          [ "parnim,0.56,0.34,0.03,0.99" "bounce,0.175, 0.885, 0.32, 1.15" ];
        enabled = 1;
        animation = [
          "border,1,7,default"
          "workspaces,1,2,default"
          "specialWorkspace,1,5,default, slidevert"
          "windowsIn,1,7,parnim,popin"
          "windowsOut,1,7,parnim,popin"
          "windowsMove,1,7,bounce,gnomed"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "on";
      };

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,22"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,22"
      ];
      workspace = [
        "special:pocket, monitor:HDMI-A-1, default:true"
        "special:aux, monitor:HDMI-A-1, default:true"
        "1, monitor:eDP-1, default:true, on-created-empty:alacritty -e ~/.local/bin/auto_tmux"
        "10, monitor:HDMI-A-1, default:true, on-created-empty:zen"
      ];

      windowrule = [
        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim, initialclass:^(ueberzugpp)"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
        "noanim,class:^(rofi)$"
        "center,floating:1"
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
      ];
      layerrule =
        [ "unset,rofi" "noanim,rofi" "unset,ueberzugpp" "noanim,ueberzugpp" ];

      exec-once = [
        "swaync"
        "hyprsunset"
        "waybar"
        "blueman-applet"
        "nm-applet"
        ''hyprctl setcursor "Bibata-Modern-Classic" 22''
      ];
      binde = [
        "$mainMod SHIFT, Tab, workspace, m-1"
        "$mainMod, Tab, workspace, m+1"
        "$mainMod, up, exec, hyprctl hyprsunset temperature +10"
        "$mainMod, down, exec, hyprctl hyprsunset temperature -10"
        "$mainMod SHIFT, I, exec, busctl --user call rs.wl-gammarelay / rs.wl.gammarelay ToggleInverted"
        ",XF86MonBrightnessUp,exec,swayosd-client --brightness=raise"
        ",XF86MonBrightnessDown,exec,swayosd-client --brightness=lower"
        ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bind = [
        "SUPER, V, exec, alacritty --class clipse -e clipse"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod SHIFT, E, exit,"
        "$mainMod SHIFT, space, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, W, togglesplit, # dwindle"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"
        "SUPER,F,fullscreen"
        "$mainMod SHIFT, F, fullscreenstate, 2, 0"
        "$mainMod, x,togglegroup"
        "$mainMod ctrl, h, changegroupactive, b"
        "$mainMod ctrl, l, changegroupactive, f"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, C, movetoworkspace, special:pocket"
        "$mainMod, C, togglespecialworkspace, pocket"
        "$mainMod SHIFT, O, movetoworkspace, special:aux"
        "$mainMod, O, togglespecialworkspace, aux"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, return, exec, alacritty"
        "$mainMod SHIFT, return, exec, alacritty -e ~/.local/bin/auto_tmux"
        "$mainMod, E, exec, alacritty -e yazi"
        "$mainMod, D, exec, rofi -show drun"
        "$mainMod, I, exec, zen"
        "$mainMod SHIFT, N, exec, hyprctl hyprsunset temperature 3500"
        "$mainMod SHIFT, M, exec,hyprctl hyprsunset identity"
        "$mainMod SHIFT, W, exec, hyprlock"
        "$mainMod, N, exec, swaync-client --toggle-panel"
        "$mainMod,XF86MonBrightnessUp,exec,light -S 100"
        "$mainMod,XF86MonBrightnessDown,exec,light -S 0"
        ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"
        ",Caps_Lock,exec,sleep 0.1 && swayosd-client --caps-lock"
        "$mainMod SHIFT, S, exec, ~/.config/hypr/screenshot"
        "$mainMod SHIFT, D, exec, ~/.config/hypr/full-screenshot"
        "$mainMod SHIFT, G, exec, ~/.local/bin/screenshot-gpt"
        "$mainMod SHIFT, B, exec, killall -SIGUSR1 .waybar-wrapped"
        ''
          $mainMod, S, exec, hyprctl dispatch sendshortcut "CTRL,V," && hyprctl dispatch sendshortcut ",RETURN,"''

      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd =
          "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd =
          "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = {
        timeout = 1800; # 30min
        on-timeout = "systemctl suspend"; # suspend pc
      };
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {

      source = "$HOME/.cache/wal/colors-hyprland.conf";
      monitor = [ "eDP-1, 3072x1920, 0x0,2, vrr, 2" ",preferred, auto, 1" ];

      auth = { fingerprint = { enabled = true; }; };

      background = {
        monitor = "";
        path = "$HOME/.config/hypr/wallpapers/Clearnight.jpg";
        blur_size = "4";
        blur_passes = "3"; # 0 disables blurring
        noise = "0.0117";
        contrast = "1.3000"; # Vibrant!!!
        brightness = "0.8000";
        vibrancy = "0.2100";
        vibrancy_darkness = "0.0";
      };

      input-field = {
        monitor = "";
        size = "400, 50";
        outline_thickness = 3;
        dots_size = 0.26; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "$color0";
        inner_color = "$color0";
        font_color = "$color6";
        fade_on_empty = true;
        placeholder_text =
          "<i>Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;

        position = "0, 90";
        halign = "center";
        valign = "bottom";
      };

      # Current time
      label = [
        {
          monitor = "";
          text =
            ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
          color = "$color6";
          font_size = 64;
          font_family = "JetBrains Mono Nerd Font 10";
          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 30";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text =
            ''cmd[update:18000000] echo "<b> "$(date +'%A, %-d %B %Y')" </b>"'';
          color = "$color7";
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font 10";

          position = "0, -30";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Hey $USER";
          color = "$color7";
          font_size = 18;
          font_family = "Inter Display Medium";

          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
  # services.blueman-applet.enable = true;
  # services.network-manager-applet.enable = true;
  services.swayosd.enable = true;
  services.hyprpolkitagent.enable = true;
  services.clipse.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "~/.config/hypr/wallpapers/Cloudsnight.jpg";
      splash = true;
      wallpaper = ",~/.config/hypr/wallpapers/Cloudsnight.jpg";
      ipc = "off";
    };
  };

}
