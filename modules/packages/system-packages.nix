{
  pkgs,
  pkgs-unstable,
  helium,
  ...
}:
# R with Packages
let
  R = pkgs-unstable.rWrapper.override {
    packages = with pkgs-unstable.rPackages; [
      remotes
      tidyverse
      ggplot2
      dplyr
      xts
    ];
  };
  rstudio = pkgs-unstable.rstudioWrapper.override {
    packages = with pkgs-unstable.rPackages; [
      bambu
      DESeq2
      ggplot2
      tidyr
      dplyr
      remotes
      data_table
    ];
  };
in {
  environment.systemPackages =
    (with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      gcc
      xclip
      openconnect
      obsidian
      wget
      curl
      kitty
      ghostty.terminfo
      ripgrep
      ghostty
      fd
      helium.packages.${system}.default
    ])
    ++ (with pkgs-unstable; [
      R
      rustc
      distrobox
      cargo
      rustup
      python314
      rstudio
    ]);
}
