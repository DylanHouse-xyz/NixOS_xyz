{
  pkgs,
  lib,
  ...
}: let
  nextflow-ls = pkgs.callPackage ./nextflow-language-server.nix {};
in {
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

    ## ------------------------------------------------------------- editor ##

    undoFile.enable = true; # undo history survives closing the file
    preventJunkFiles = true; # no swap/backup files dropped into your repos

    spellcheck = {
      enable = true;
      programmingWordlist.enable = true; # don't flag camelCase identifiers
    };

    options = {
      number = true;
      relativenumber = true;
      signcolumn = "yes"; # stops the gutter shifting when diagnostics appear
      scrolloff = 8;
      updatetime = 250;
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    binds.whichKey.enable = true;

    clipboard = {
      enable = true;
      providers = {
        xclip.enable = true;
        xclip.package = pkgs.xclip;
      };
    };

    ## --------------------------------------------------------- completion ##

    autocomplete.nvim-cmp.enable = true;
    snippets.luasnip.enable = true;
    autopairs.nvim-autopairs.enable = true;
    comments.comment-nvim.enable = true; # gcc / gc{motion}
    utility.surround.enable = true;

    git.gitsigns.enable = true;

    visuals = {
      nvim-web-devicons.enable = true;
      indent-blankline.enable = true;
      fidget-nvim.enable = true;
    };

    terminal.toggleterm.enable = true; # run nextflow / Rscript without leaving nvim

    ## ---------------------------------------------------------------- LSP ##

    lsp = {
      enable = true;

      lspkind.enable = true; # kind icons in the completion menu
      lightbulb.enable = true; # sign in the gutter when a code action exists
      lspSignature.enable = true; # parameter hints while you type a call
      trouble.enable = true; # project-wide diagnostics/references list
      #  lsplines.enable = true; # diagnostics as virtual lines under the offending code
      otter-nvim.enable = true; # LSP inside embedded code blocks — Rmd / Quarto / md

      servers.nextflow_ls = {
        enable = true;
        cmd = [(lib.getExe nextflow-ls)];
        filetypes = ["nextflow"];
        root_markers = [
          "nextflow.config"
          "main.nf"
          "nf-test.config"
          ".git"
        ];
        settings.nextflow = {
          files.exclude = [".git" ".nf-test" "work" "results"];
          suppressFutureWarnings = true;
          errorReportingMode = "warnings"; # off | errors | warnings | paranoid
          telemetry.enabled = false;
          typeChecking = false; # turn on once you've moved to strict syntax
        };
      };
    };

    formatter.conform-nvim = {
      enable = true;
      setupOpts.format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };

    ## ----------------------------------------------------------- debugger ##

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
    extraPlugins.nvim-dap-virtual-text = {
      package = pkgs.vimPlugins.nvim-dap-virtual-text;
      setup = "require('nvim-dap-virtual-text').setup {}";
    };

    ## ---------------------------------------------------------- languages ##

    languages = {
      enableTreesitter = true;
      enableFormat = true;

      enableDAP = true;
      enableExtraDiagnostics = true;

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

    ## ------------------------------------------------------------ nextflow ##

    treesitter.enable = true;

    treesitter.grammars = [
      pkgs.vimPlugins.nvim-treesitter.grammarPlugins.groovy
    ];

    # Puts `nextflow` on nvim's PATH, so :!nextflow lint % and :ToggleTerm work.
    extraPackages = [pkgs.nextflow];

    luaConfigRC.nextflow = ''
      -- Neovim has no built-in ftdetect for Nextflow.
      vim.filetype.add({
        extension = { nf = "nextflow" },
        filename = { ["nextflow.config"] = "nextflow" },
      })

      -- Route the `nextflow` filetype at the Groovy parser.
      vim.treesitter.language.register("groovy", "nextflow")

      -- nvim-treesitter keeps its own filetype→parser map and doesn't know
      -- about `nextflow`, so start the parser ourselves.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nextflow",
        callback = function()
          pcall(vim.treesitter.start)
        end,
        desc = "Start Tree-sitter (groovy) for Nextflow buffers",
      })
    '';
  };
}
