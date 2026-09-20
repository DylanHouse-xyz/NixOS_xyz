{...}: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''

    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ../";
      uob = "ssh housed@bluebear.bham.ac.uk"; # my ssh
      os-rebuild = "cd /etc/nixos/ && sudo nixos-rebuild switch --flake . && cd -";
      home-rebuild = "home-manager switch -f /etc/nixos/home.nix";
    };
    initExtra = ''
      if [ -z "$TMUX" ]; then
        tmux
      fi
      [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
    '';
  };
}
