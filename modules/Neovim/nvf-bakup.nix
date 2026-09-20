{pkgs, ...}: {
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

    formatter.conform-nvim = {
      enable = true;
      setupOpts.format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };

    languages = {
      enableTreesitter = true;
      enableDAP = true;
      enableFormat = true;

      r = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
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
      nix = {
        enable = true;
        lsp.enable = true;
      };
    };
  };
}
