{ pkgs, ... }: {
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
  ];

  programs.lsd.enable = true;

  programs.zsh = {
    enable = true;
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
      export PATH=$HOME/.local/bin:$PATH
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

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

}
