{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

environment.systemPackages = with pkgs; [
    
    python311Packages.python-lsp-server   # Python LSP server
    lua-language-server                   # Lua LSP server
  
    pylint                # Linting for Python
    markdownlint-cli2     # Linting for markdown

    lazygit               # Terminal UI for git commands
  ];
}
