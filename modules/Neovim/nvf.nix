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

  languages = {
    enableTreesitter = true;


  r.enable = true;
  r.lsp.enable = true;

  python.enable = true;
  python.lsp.enable = true;

  rust.enable = true;
  rust.lsp.enable = true;

  bash.enable = true;
  bash.lsp.enable = true;  


  
  };
 };
}
