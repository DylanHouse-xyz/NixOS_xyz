{ pkgs, lib, ... }:

{

  vim = {

    globals.mapleader = " ";
 
    keymaps = [
      # Clear highlights on search when pressing <Esc> in normal mode
      {
        mode = [ "n" ];
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        desc = "Clear search highlights";
      }

      # Diagnostic keymaps
      {
        mode = [ "n" ];
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        desc = "Go to previous diagnostic message";
      }
      {
        mode = [ "n" ];
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        desc = "Go to next diagnostic message";
      }
      {
        mode = [ "n" ];
        key = "<leader>e";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        desc = "Open floating diagnostic message";
      }
      {
        mode = [ "n" ];
        key = "<leader>q";
        action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
        desc = "Open diagnostic quickfix list";
      }

      # Window navigation shortcuts
      {
        mode = [ "n" ];
        key = "<C-h>";
        action = "<C-w>h";
        desc = "Move focus to the left window";
      }
      {
        mode = [ "n" ];
        key = "<C-l>";
        action = "<C-w>l";
        desc = "Move focus to the right window";
      }
      {
        mode = [ "n" ];
        key = "<C-j>";
        action = "<C-w>j";
        desc = "Move focus to the lower window";
      }
      {
        mode = [ "n" ];
        key = "<C-k>";
        action = "<C-w>k";
        desc = "Move focus to the upper window";
      }
    ];  
  };
}
