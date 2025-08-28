{ pkgs, ... }: {
  home.packages = with pkgs; [ zsh-autosuggestions zsh-syntax-highlighting ];

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      droidcam-front =
        "scrcpy --video-source=camera --camera-facing=front --camera-size=2560x1440 --video-codec=h264 --v4l2-sink=/dev/video10 --no-audio --no-video-playback";
      droidcam-back =
        "scrcpy --video-source=camera --camera-facing=back --camera-size=2560x1440 --video-codec=h264 --v4l2-sink=/dev/video10 --no-audio --no-video-playback";
      tree = "eza --icons=always --tree";
      ipinfo = "ip -br -c a";
      graph = "git log --oneline --graph --all --decorate";
      sudo = "sudo -A";
      vim = "nvim";
      nixgc =
        "(cd ~/nixos-config && nix-env --delete-generations old && nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo nixos-rebuild switch --install-bootloader)";
      nixupgrade =
        "(cd ~/nixos-config && nix flake update && sudo nixos-rebuild switch)";
      nixupdate = "(cd ~/nixos-config && sudo nixos-rebuild switch)";
      ports = "sudo netstat -tulpen";
      open-dir = "nohup nautilus . > /dev/null 2>&1 &";
    };

    sessionVariables = {
      SUDO_ASKPASS = "$(which systemd-ask-password)";
      PATH = "$HOME/.local/bin:$HOME/go/bin:$PATH";
    };

    initContent = ''
      if [[ -z "$TMUX" ]]; then
        fastfetch
      fi
      # Key bindings
      bindkey -v # enable vi mode
      bindkey '^F' forward-char
      bindkey "^P" up-line-or-beginning-search
      bindkey "^N" down-line-or-beginning-search
      # Source secrets file if it exists
      if [[ -f ~/.secrets ]]; then
        source ~/.secrets
      fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      extraConfig = ''
        # Enable zsh-autosuggestions and zsh-syntax-highlighting
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      '';
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    ANDROID_HOME = "$HOME/Android/Sdk";
    PATH = "$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = { vim = "nvim"; };
  };

}
