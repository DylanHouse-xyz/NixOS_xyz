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
      nf-core = "./~/Projects/nf-corepkg/result/bin/nf-core";
    };
    initExtra = ''
      [ "$TERM" = "xterm-ghostty" ]
    '';
  };
}
