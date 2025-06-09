{ ssh_public, fullName, email, homeDirectory, ... }: {
  programs.ssh.enable = true;

  # SSH Git config
  home.file.".ssh/id_ed25519.pub" = {
    text = ''
      ${ssh_public}
    '';
    target = ".ssh/id_ed25519.pub";
    executable = false;
  };

  programs.git = {
    enable = true;
    userName = fullName;
    userEmail = email;
    signing.key = "${homeDirectory}/.ssh/id_ed25519.pub";
    signing.format = "ssh";
    signing.signByDefault = true;
    extraConfig = {
      gpg.ssh.allowedSignersFile =
        "${homeDirectory}/.config/git/allowed_signers";
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
