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
      zed = "zeditor";
    };

    sessionVariables = {
      SUDO_ASKPASS = "$(which systemd-ask-password)";
      PATH = "$HOME/.local/bin:$PATH";
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

  home.sessionVariables = { EDITOR = "nvim"; };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      zed = "zeditor";
      vim = "nvim";
    };
  };

}
