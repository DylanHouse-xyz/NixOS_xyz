{
  buildFishPlugin,
  fetchFromGitHub,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      uob = "ssh housed@bluebear.bham.ac.uk";
      os-rebuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake . && cd -";
      home-rebuild = "home-manager switch -f /etc/nixos/home.nix";
      la = "eza -la --color=always --group-directories-first --icons --git";
      ls = "eza --color=always --group-directories-first --icons";
      ll = "eza -l --color=always --group-directories-first --icons --git";
    };

    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
