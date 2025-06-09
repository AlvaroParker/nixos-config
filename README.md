# NixOS configuration

You'll need to create a `vars.nix` file in the root directory of this repo with the following content:

```nix
rec {
  username = "<your username>";
  nickName = "<your name for gdm>";
  fullName = "<your name for git>";
  email = "<your git email>";
  hostname = "<your hostname>";
  homeDirectory = "/home/<user>";
  ssh_public = ''<YOUR PUBLIC KEY - NOT NEW LINE TERMINATED'';
}
```
