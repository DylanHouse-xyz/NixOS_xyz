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
    };

    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
