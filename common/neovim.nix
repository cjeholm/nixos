{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    python311Packages.python-lsp-server
    lua-language-server   # Python LSP server
    pylint                # Linting for Python
    markdownlint-cli2     # Linting for markdown
  ];
}
