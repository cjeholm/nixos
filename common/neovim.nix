{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    
    neovim

    python311Packages.python-lsp-server   # Python LSP server
    lua-language-server                   # Lua LSP server
  
    pylint                # Linting for Python
    markdownlint-cli2     # Linting for markdown

    lazygit               # Terminal UI for git commands
  ];
}
