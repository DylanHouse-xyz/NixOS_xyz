{ pkgs, lib, ... }:

{

  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

  statusline.lualine.enable = true;
  telescope.enable = true;
  autocomplete.nvim-cmp.enable = true;

  binds.whichKey.enable = true;

  clipboard = {
    enable = true;
    providers = {
      xclip.enable = true;
      xclip.package = pkgs.xclip;
    };
  };

  languages = {
    enableTreesitter = true;
  r ={
    enable = true;
    lsp.enable = true;
   };
  python = {
    enable = true;
    lsp.enable = true;
   };
  rust = {
    enable = true;
    lsp.enable = true;
   };
  bash = {
    enable = true;
    lsp.enable = true;
   };
  };
 };
}
