{pkgs, ...}: {
  programs.ghostty = {
    enable = true;

    package =
      if pkgs.stdenv.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;

    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      theme = "Catppuccin Frappe";
      background-opacity = "0.95";
      command = "fish";

      keybind = "alt+-=new_split:right";
    };
  };
}
