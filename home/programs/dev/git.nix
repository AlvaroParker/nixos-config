{ pkgs, ssh_public, fullName, email, homeDirectory, unstable, ... }: {
  programs.ssh.enable = true;

  programs.gh-dash.enable = true;

  # SSH Git config
  home.file.".ssh/id_ed25519.pub" = {
    text = ''
      ${ssh_public}
    '';
    target = ".ssh/id_ed25519.pub";
    executable = false;
  };

  programs.gpg = { enable = true; };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = fullName;
    extraConfig = { init.defaultBranch = "main"; };
    userEmail = email;
    signing.key = "${homeDirectory}/.ssh/id_ed25519.pub";
    signing.format = "ssh";
    signing.signByDefault = true;
    delta = { enable = true; };
    aliases = {
      st = "status --short --branch";
      plog = ''
        log --oneline --decorate --shortstat --color=always --pretty=format:"%C(auto)%h %d %s %Cgreen[%an]"'';
      recent = ''
        log --oneline  --decorate=short --shortstat --color=always --date=relative --pretty=format:"%C(auto)%h %C(auto)%d %s %n %C(yellow) └─> %Cgreen[%an] %C(bold blue)(%ad) %C(yellow)" -10'';
      nice-log = ''
        log --oneline  --decorate=short --shortstat --color=always --date=relative --pretty=format:"%C(auto)%h %C(auto)%d %s %n %C(yellow) └─> %Cgreen[%an] %C(bold blue)(%ad) %C(yellow)"'';
      co = "checkout";
      br = "branch";
      cm = "commit -m";
      df = "diff";
      lg = "log --oneline --graph --decorate --all";
      last = "log -1 HEAD";
      unstage = "reset HEAD --";
      amend = "commit --amend";
      fu = "fetch upstream";
    };
    extraConfig = {
      gpg.ssh.allowedSignersFile =
        "${homeDirectory}/.config/git/allowed_signers";
      pull.rebase = true;
      rerere.enabled = true;
    };
  };

  programs.gh = {
    package = unstable.gh;
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = { theme = "mocha"; };
    themes = {
      mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "699f60fc8ec434574ca7451b444b880430319941";
          sha256 = "1lirgwgh2hnz6j60py19bbmhvgaqs7i6wf6702k6n83lgw4aixg9";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  home.file.".config/git/allowed_signers" = {
    text = ''
      ${fullName} <${email}> <${ssh_public}>
    '';
    target = ".config/git/allowed_signers";
    executable = false;
  };
}
