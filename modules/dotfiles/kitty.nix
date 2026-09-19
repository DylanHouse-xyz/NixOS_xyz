
{ config, pkgs, ... }:

{

 programs.kitty = {

    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
    
    themeFile = "tokyo_night_night";
    settings = {
      background_opacity = "0.9";
      cursor_shape = "beam";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      
    };
  };

}
