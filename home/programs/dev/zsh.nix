{ pkgs, ... }: {
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
  ];

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      tree = "eza --icons=always --tree";
      ipinfo = "ip -br -c a";
      graph = "git log --oneline --graph --all --decorate";
      sudo = "sudo -A";
      vim = "nvim";
      nixgc = "sudo nix-collect-garbage -d";
      nixupgrade =
        "(cd ~/nixos-config && nix flake update && sudo nixos-rebuild switch)";
      nixupdate = "(cd ~/nixos-config && sudo nixos-rebuild switch)";
      ports = "sudo netstat -tulpen";
    };

    sessionVariables = {
      SUDO_ASKPASS = "$(which systemd-ask-password)";
      PATH = "$HOME/.local/bin:$HOME/go/bin:$PATH";
    };

    initContent = ''
      if [[ -z "$TMUX" ]]; then
        fastfetch
      fi
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
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
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh
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
