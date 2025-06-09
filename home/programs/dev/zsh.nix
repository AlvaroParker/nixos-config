{ pkgs, ... }: {
  home.packages = with pkgs; [ zsh-autosuggestions zsh-syntax-highlighting ];

  programs.lsd.enable = true;

  programs.zsh = {
    enable = true;
    initContent = ''
      if [[ -z "$TMUX" ]]; then
        fastfetch
      fi
      alias ls='lsd'
      alias nv='nvim'
      alias tree='eza --icons=always --tree'
      alias ipinfo='ip -br -c a'
      alias graph='git log --oneline --graph --all --decorate'
      alias sudo='sudo -A'
      alias vim='nvim'
      alias zed='zeditor'
      export SUDO_ASKPASS=$(which systemd-ask-password)

      # Key bindings
      bindkey -v # enable vi mode
      bindkey '^F' forward-char
      bindkey "^P" up-line-or-beginning-search
      bindkey "^N" down-line-or-beginning-search
    '';
    oh-my-zsh = {
      enable = true;
      # git zsh-autosuggestions zsh-syntax-highlighting
      plugins = [ "git" ];
      theme = "agnoster";
      extraConfig = ''
        # Enable zsh-autosuggestions and zsh-syntax-highlighting
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      '';
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

}
