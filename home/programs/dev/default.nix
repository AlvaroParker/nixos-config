{ pkgs, ... }: {
  imports = [ ./zsh.nix ./fastfetch.nix ./git.nix ./others.nix ./neovim.nix ];

  programs.eza.enable = true;

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_left_separator "#[bg=default,fg=#{@thm_surface_0}]#[bg=#{@thm_surface_0},fg=#{@thm_fg}]"
          set -g @catppuccin_window_right_separator "#[bg=default,fg=##9399B2]"
          set -g @catppuccin_window_current_left_separator "#[bg=default,fg=#{@thm_surface_1}]#[bg=#{@thm_mauve},fg=#{@thm_bg}]"
          set -g @catppuccin_window_current_right_separator "#[bg=default,fg=#{@thm_mauve}]"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text " #W"
          set -g status-position top
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_date_time}"

          set -g status-position top
        '';
      }
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g prefix C-b
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      bind a new-session -c "#{pane_current_path}"
      bind m attach-session -c "#{pane_current_path}"

      # Configure the catppuccin plugin
      set -g @catppuccin_flavor "mocha"

      setw -g mode-keys vi

      # Easier pane navigation with Ctrl + h/j/k/l
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      # Resize panes using Vim-style keys
      bind -r h resize-pane -L 5
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
    '';
  };
}
