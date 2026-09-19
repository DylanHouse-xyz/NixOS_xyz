{ config, pkgs, pkgs-unstable, helium, ... }:



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
in
{
  environment.systemPackages = 
    (with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    gcc
    openconnect
    obsidian
    rustc
    cargo
    rustup
    wget
    curl
    kitty
    kitty.terminfo
    ripgrep
    fd
    helium.packages.${system}.default
  ])

   ++

   (with pkgs-unstable; [
     nextflow
     R
     rstudio

  ]);
}
