{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

environment.systemPackages = with pkgs; [
    
    python311Packages.python-lsp-server   # Python LSP server
    lua-language-server                   # Lua LSP server
    clang-tools                           # C++ LSP server
  
    pylint                # Linting for Python
    markdownlint-cli2     # Linting for markdown

    stylua                # Lua formatter
    vimPlugins.vim-prettier
    vimPlugins.rocks-nvim
    luajitPackages.jsregexp

    lazygit               # Terminal UI for git commands

    xsel                  # For clipboard
    ripgrep               # For Telescope previews
    fd                    # find alternative
  ];
}
